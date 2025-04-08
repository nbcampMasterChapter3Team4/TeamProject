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
    
    private var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    private enum Section: Int, CaseIterable {
        case bigOne, grid2
        var columnCount: Int {
            switch self {
            case .bigOne:
                return 1
                
            case .grid2:
                return 2
            }
        }
    }
    typealias Item = IEProduct
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    // Test data
    
    
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
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .systemTeal
        collectionView.delegate = self
        configureDataSource()
    }
    
    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<ItemCell, Item> { cell, indexPath, item in
            cell.configure()
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        })
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let section = Section(rawValue: sectionIndex) else { return nil }
            let columns = section.columnCount
            
            return self.createSection(columns: columns)
        }
        
        return layout
    }
    
    func createSection(columns: Int) -> NSCollectionLayoutSection {
        let standardWidth: CGFloat = 402
        let space: CGFloat = 13
        var itemWidth: CGFloat = 0
        
        if columns == 1 {
            itemWidth = standardWidth - space * 2 / standardWidth
        } else if columns == 2 {
            itemWidth = (standardWidth - space * 3) / 2 / standardWidth
        }
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(itemWidth), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(184 / 874))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
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
