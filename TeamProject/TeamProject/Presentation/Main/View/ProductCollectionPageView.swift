//
//  ProductCollectionPageView.swift
//  TeamProject
//
//  Created by 서동환 on 4/9/25.
//

import UIKit

import SnapKit
import Then

class ProductCollectionPageView: BaseView {
    
    // MARK: - UI Components

    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    private let pageControl = UIPageControl().then {
        $0.currentPageIndicatorTintColor = UIColor.blue200
        $0.pageIndicatorTintColor = UIColor.gray400
    }
    
    // MARK: - Properties
    
    private var products: [IEProduct] = []
    
    private let horizontalInsets = NSDirectionalEdgeInsets(top: 0, leading: 6.5, bottom: 0, trailing: 6.5)
    private let verticalInsets = NSDirectionalEdgeInsets(top: 6.5, leading: 0, bottom: 6.5, trailing: 0)
    
    private var pageCount: Int = 0
    enum Section: Hashable {
        case page(Int)
    }
    typealias Item = IEProduct
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    // MARK: - Style Helper
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAddTarget()
        configureDataSource()
        reloadData(animated: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setStyles() {
        setCollectionView()
    }
    
    // MARK: - Layout Helper
    
    override func setLayout() {
        self.addSubviews(collectionView, pageControl)
        
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 578 / 874)
        }
        
        pageControl.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
    func setAddTarget() {
        pageControl.addTarget(self, action: #selector(didChangeValue(_:)), for: .valueChanged)
    }
    
    func setData(products: [IEProduct], animated: Bool) {
        self.products = products
        reloadData(animated: animated)
        reloadPageControl()
    }
    
    @objc
    func didChangeValue(_ sender: UIPageControl) {
        let indexPath = IndexPath(item: 0, section: sender.currentPage)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
    }
}

// MARK: - CollectionView Methods

private extension ProductCollectionPageView {
    func setCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnv in
            return self.createSection(page: sectionIndex)
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal
        layout.configuration = config
        
        return layout
    }
    
    func createItem(width: CGFloat) -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(width),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = horizontalInsets
        return item
    }
    
    func createRowGroup(column: Int, item: NSCollectionLayoutItem) -> NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1 / 3)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: column)
        group.contentInsets = verticalInsets
        
        return group
    }
    
    func createPageGroup(items: [NSCollectionLayoutItem]) -> NSCollectionLayoutGroup {
        let pageGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let pageGroup = NSCollectionLayoutGroup.vertical(layoutSize: pageGroupSize, subitems: items)
        pageGroup.contentInsets = horizontalInsets
        
        return pageGroup
    }
    
    func createSection(page: Int) -> NSCollectionLayoutSection {
        // item
        // 첫 번째 페이지 맨 위 아이템 사이즈(넓은 셀)
        let fullWidthitem = createItem(width: 1.0)
        // 나머지 아이템 사이즈 (절반 셀)
        let twoColumnitem = createItem(width: 0.5)
        
        // group
        let firstRowColumn = (page == 0) ? 1 : 2
        let firstRowItem = (page == 0) ? fullWidthitem : twoColumnitem
        let firstRow = createRowGroup(column: firstRowColumn, item: firstRowItem)
        let secondRow = createRowGroup(column: 2, item: twoColumnitem)
        let thirdRow = secondRow
        // 한 페이지를 나타내는 group
        let pageGroup = createPageGroup(items: [firstRow, secondRow, thirdRow])
        
        // section
        let section = NSCollectionLayoutSection(group: pageGroup)
        section.visibleItemsInvalidationHandler = { item, offset, env in
            let index = Int((offset.x / env.container.contentSize.width).rounded(.toNearestOrEven))
            print(">>> \(index)")
            self.pageControl.currentPage = index
        }
        
        return section
    }
    
    func configureDataSource() {
        let bestCellRegistation = UICollectionView.CellRegistration<BestItemCell, Item> { cell, indexPath, item in
            cell.configure(title: item.name, image: item.productImage, price: item.price)
        }
        
        let itemCellRegistration = UICollectionView.CellRegistration<MiniItemCell, Item> { cell, indexPath, item in
            cell.configure(title: item.name, image: item.productImage, price: item.price)
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            // 맨 처음 셀에만 BestItemCell 할당
            if indexPath.section == 0, indexPath.item == 0 {
                return collectionView.dequeueConfiguredReusableCell(using: bestCellRegistation, for: indexPath, item: item)
            } else {
                return collectionView.dequeueConfiguredReusableCell(using: itemCellRegistration, for: indexPath, item: item)
            }
        })
    }
    
    func reloadData(animated: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        // 데이터 앞 5개 저장(첫 번째 페이지)
        let firstPageItems = Array(products.prefix(5))
        snapshot.appendSections([.page(pageCount)])
        snapshot.appendItems(firstPageItems, toSection: .page(pageCount))
        pageCount += 1
        
        let remainingProducts = Array(products.dropFirst(5))
        // 6개씩 나눠서 배열로 저장
        let otherPageItems = stride(from: 0, to: remainingProducts.count, by: 6).map {
            Array(remainingProducts[$0..<min($0 + 6, remainingProducts.count)])
        }
        for items in otherPageItems {
            snapshot.appendSections([.page(pageCount)])
            snapshot.appendItems(items, toSection: .page(pageCount))
            pageCount += 1
        }
        
        dataSource.apply(snapshot, animatingDifferences: animated)
    }
    
    func reloadPageControl() {
        pageControl.numberOfPages = collectionView.numberOfSections
        pageControl.currentPage = 0
        let indexPath = IndexPath(item: 0, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
    }
}

// MARK: - UICollectionViewDelegate

extension ProductCollectionPageView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath) cell pressed.")
    }
}

