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
    
//    private let collectionView = UICollectionView()
    
    // MARK: - Properties
    
//    private enum Section: Int {
//        case bigOne([dataSo])
//        case grid
//    }
//    typealias Item = IEProduct
//    private let dataSource: [Section] = [
//        .bigOne.
//
//    ]
    
    override func setStyles() {
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.isHidden = true;
        
//        setCollectionView()
    }
    
    override func setLayout() {
        self.view.addSubview(segmentedControl)
//        self.view.addSubview(collectionView)
        
        segmentedControl.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(10)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(16)
        }
        
//        collectionView.snp.makeConstraints {
//            $0.top.equalTo(segmentedControl.snp.bottom).offset(28)
//            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(12)
//        }
    }
}

// MARK: - UI Methods

//private extension ViewController {
//    func setCollectionView() {
//        let layout = UICollectionViewCompositionalLayout {
//            
//        }
//    }
//    
//    func layout() -> UICollectionViewCompositionalLayout {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
//        let group = NSCollectionLayoutGroup.
//    }
//}
//
//private extension ViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        switch
//    }
//}
