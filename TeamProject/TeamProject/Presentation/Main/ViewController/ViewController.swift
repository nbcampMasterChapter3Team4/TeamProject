//
//  ViewController.swift
//  TeamProject
//
//  Created by 서동환 on 4/4/25.
//

import UIKit

import SnapKit
import Then

class ViewController: BaseViewController {
        
    // MARK: - UI Components
    
    private let segmentedControl = UISegmentedControl().then {
        $0.backgroundColor = UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .light {
                return UIColor.gray80
            } else {
                return UIColor.gray600
            }
        }
        
        $0.insertSegment(withTitle: "All", at: 0, animated: true)
        $0.insertSegment(withTitle: "iPhone", at: 1, animated: true)
        $0.insertSegment(withTitle: "Mac", at: 2, animated: true)
        $0.insertSegment(withTitle: "iPad", at: 3, animated: true)
        $0.insertSegment(withTitle: "ACC", at: 4, animated: true)
        $0.selectedSegmentIndex = 0
    }
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    // MARK: - Properties
    
    private enum Section: Int, CaseIterable {
        case main
    }
    typealias Item = IEProduct
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    override func setStyles() {
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.isHidden = true;
        
        setCollectionView()
    }
    
    override func setLayout() {
        self.view.addSubview(segmentedControl)
        self.view.addSubview(collectionView)
        
        segmentedControl.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(10)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(16)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(segmentedControl.snp.bottom).offset(27)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(13)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(134)  // 임시 레이아웃
        }
    }
}

// MARK: - CollectionView Methods

private extension ViewController {
    func setCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        configureDataSource()
    }
    
    func configureDataSource() {
        let bigProduct = IEProduct(
            id: UUID(),
            name: "iPhone16",
            imageName: "iPhone16",
            price: 1230000,
            description: "테스트",
            color: .blackTitanium,
            category: .iPhone
        )
        
        var testIEProduct = [IEProduct]()
        for _ in 1...10 {
            let gridProduct = IEProduct(
                id: UUID(),
                name: "iPhone15",
                imageName: "iPhone15",
                price: 4560000,
                description: "테스트",
                color: .desertTitanium,
                category: .iPhone
            )
            testIEProduct.append(gridProduct)
        }
        
        
        let cellRegistration = UICollectionView.CellRegistration<ItemCell, Item> { cell, indexPath, item in
            cell.configure()
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(testIEProduct)
        dataSource.applySnapshotUsingReloadData(snapshot)
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            return self.createSection()
        }
        
        return layout
    }
    
    func createSection() -> NSCollectionLayoutSection {
        let standardWidth: CGFloat = 402
        let space: CGFloat = 13
        let itemWidth: CGFloat = (standardWidth - space * 3) / 2 / standardWidth
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(itemWidth), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(184 / 874))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(13)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 26

        return section
    }
}

// MARK: - UICollectionViewDelegate

extension ViewController: UICollectionViewDelegate {
    
}
