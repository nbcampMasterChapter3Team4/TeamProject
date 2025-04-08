//
//  ItemCollectionPageView.swift
//  TeamProject
//
//  Created by 서동환 on 4/9/25.
//

import UIKit

import SnapKit
import Then

class ItemCollectionPageView: BaseView {
    
    // MARK: - UI Components

    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    private let pageControl = UIPageControl().then {
        $0.currentPageIndicatorTintColor = UIColor.blue200
        $0.pageIndicatorTintColor = UIColor.gray400
    }
    
    // MARK: - Properties
    
    enum Section: Int, CaseIterable {
        case firstPage
        case otherPage
    }
    typealias Item = IEProduct
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    // MARK: - Lifecycle
    
    override func setStyles() {
        setCollectionView()
//        pageControl.numberOfPages =
    }
    
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
}

// MARK: - CollectionView Methods

private extension ItemCollectionPageView {
    func setCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        configureDataSource()
    }
    
    func configureDataSource() {
        // 테스트 용도
        var testIEProduct = [IEProduct]()
        for i in 1...18 {
            let gridProduct = IEProduct(
                id: UUID(),
                name: "iPhone 16 Pro",
                imageName: "iPhone16Pro",
                price: 500_000 * i,
                description: "테스트",
                color: .desertTitanium,
                category: .iPhone
            )
            testIEProduct.append(gridProduct)
        }
        
        let exceptFirstPage = testIEProduct.count - 5
        let pageCount = exceptFirstPage % 6 == 0 ? exceptFirstPage / 6 + 1 : exceptFirstPage / 6 + 2
        pageControl.numberOfPages = pageCount
        
        let bestCellRegistation = UICollectionView.CellRegistration<BestItemCell, Item> { cell, indexPath, item in
            cell.configure(title: item.name, image: ImageLiterals.Main.iPhone15, price: item.price)  // 이미지는 테스트용
        }
        
        let itemCellRegistration = UICollectionView.CellRegistration<MiniItemCell, Item> { cell, indexPath, item in
            cell.configure(title: item.name, image: ImageLiterals.Main.iPhone16Pro, price: item.price)  // 이미지는 테스트용
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            if indexPath.section == 0, indexPath.item == 0 {
                return collectionView.dequeueConfiguredReusableCell(using: bestCellRegistation, for: indexPath, item: item)
            } else {
                return collectionView.dequeueConfiguredReusableCell(using: itemCellRegistration, for: indexPath, item: item)
            }
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.firstPage, .otherPage])
        
        let firstPageItems = Array(testIEProduct.prefix(5))  // 테스트 용도
        let otherPageItems = Array(testIEProduct.dropFirst(5))  // 테스트 용도
        snapshot.appendItems(firstPageItems, toSection: .firstPage)
        snapshot.appendItems(otherPageItems, toSection: .otherPage)
        dataSource.apply(snapshot, animatingDifferences: false)
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
        
        let fullWidthitemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let twoColumnitemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1.0)
        )
        let fullWidthitem = NSCollectionLayoutItem(layoutSize: fullWidthitemSize)
        let twoColumnitem = NSCollectionLayoutItem(layoutSize: twoColumnitemSize)
        fullWidthitem.contentInsets = horizontalInsets
        twoColumnitem.contentInsets = horizontalInsets
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1 / 3)
        )
        let firstRow: NSCollectionLayoutGroup
        if page == .firstPage {
            firstRow = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: fullWidthitem, count: 1)
        } else {
            firstRow = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: twoColumnitem, count: 2)
        }
        let secondRow = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: twoColumnitem, count: 2)
        let thirdRow = secondRow
        firstRow.contentInsets = verticalInsets
        secondRow.contentInsets = verticalInsets
        thirdRow.contentInsets = verticalInsets
        
        let nestedGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: nestedGroupSize, subitems: [firstRow, secondRow, thirdRow])
        nestedGroup.contentInsets = horizontalInsets
        
        let section = NSCollectionLayoutSection(group: nestedGroup)
        section.visibleItemsInvalidationHandler = { item, offset, env in
            let index = Int((offset.x / env.container.contentSize.width).rounded(.toNearestOrEven))
            print(">>> \(index)")
            self.pageControl.currentPage = index
        }
        
        return section
    }
}

// MARK: - UICollectionViewDelegate

extension ItemCollectionPageView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath) cell pressed.")
    }
}

