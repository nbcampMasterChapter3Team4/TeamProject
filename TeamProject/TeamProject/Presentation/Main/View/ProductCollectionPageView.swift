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
    
    enum Section: Int, CaseIterable {
        case firstPage
        case otherPage
    }
    typealias Item = IEProduct
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    // MARK: - Style Helper
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    
    func setData(products: [IEProduct], animated: Bool) {
        self.products = products
        reloadData(animated: animated)
        reloadPageControl()
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
            guard let page = Section(rawValue: sectionIndex) else { return nil }
            return self.createSection(page: page)
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal
        layout.configuration = config
        
        return layout
    }
    
    func createSection(page: Section) -> NSCollectionLayoutSection {
        let horizontalInsets = NSDirectionalEdgeInsets(top: 0, leading: 6.5, bottom: 0, trailing: 6.5)
        let verticalInsets = NSDirectionalEdgeInsets(top: 6.5, leading: 0, bottom: 6.5, trailing: 0)
        
        // item
        // 첫 번째 페이지 맨 위 아이템 사이즈(넓은 셀)
        let fullWidthitemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        // 나머지 아이템 사이즈 (절반 셀)
        let twoColumnitemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1.0)
        )
        let fullWidthitem = NSCollectionLayoutItem(layoutSize: fullWidthitemSize)
        let twoColumnitem = NSCollectionLayoutItem(layoutSize: twoColumnitemSize)
        fullWidthitem.contentInsets = horizontalInsets
        twoColumnitem.contentInsets = horizontalInsets
        
        // group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1 / 3)
        )
        let firstRowItem = (page == .firstPage) ? fullWidthitem : twoColumnitem
        let firstRowCount = (page == .firstPage) ? 1 : 2
        let firstRow = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: firstRowItem, count: firstRowCount)
        let secondRow = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: twoColumnitem, count: 2)
        let thirdRow = secondRow
        firstRow.contentInsets = verticalInsets
        secondRow.contentInsets = verticalInsets
        thirdRow.contentInsets = verticalInsets
        // 한 페이지를 나타내는 group
        let nestedGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: nestedGroupSize, subitems: [firstRow, secondRow, thirdRow])
        nestedGroup.contentInsets = horizontalInsets
        
        // section
        let section = NSCollectionLayoutSection(group: nestedGroup)
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
            if indexPath.section == 0, indexPath.item == 0 {
                return collectionView.dequeueConfiguredReusableCell(using: bestCellRegistation, for: indexPath, item: item)
            } else {
                return collectionView.dequeueConfiguredReusableCell(using: itemCellRegistration, for: indexPath, item: item)
            }
        })
    }
    
    func reloadData(animated: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.firstPage, .otherPage])
        
        let firstPageItems = Array(products.prefix(5))
        let otherPageItems = Array(products.dropFirst(5))
        snapshot.appendItems(firstPageItems, toSection: .firstPage)
        snapshot.appendItems(otherPageItems, toSection: .otherPage)
        dataSource.apply(snapshot, animatingDifferences: animated)
    }
    
    func reloadPageControl() {
        let exceptFirstPage = products.count - 5
        let pageCount = exceptFirstPage % 6 == 0 ? exceptFirstPage / 6 + 1 : exceptFirstPage / 6 + 2
        pageControl.currentPage = 0
        pageControl.numberOfPages = pageCount
        // TODO: 데이터 리로드 시 0번 인덱스로 스크롤
        // TODO: 페이지 슬라이드 시 스크롤
    }
}

// MARK: - UICollectionViewDelegate

extension ProductCollectionPageView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath) cell pressed.")
    }
}

