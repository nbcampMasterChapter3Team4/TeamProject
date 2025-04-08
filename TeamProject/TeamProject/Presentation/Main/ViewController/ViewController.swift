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
        
        $0.setTitleTextAttributes(
            [.foregroundColor:
                UIColor { traitCollection in
                    if traitCollection.userInterfaceStyle == .light {
                        return UIColor.black100
                    } else {
                        return UIColor.white200
                    }
                }], for: .normal)
    }
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    private let bottomButtonView = CustomBottomButton().then {
        $0.configure("₩190,000", "결제하기")
    }
    
    // MARK: - Properties
    
    enum Section: Int, CaseIterable {
        case firstPage
        case otherPage
    }
    typealias Item = IEProduct
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAddTarget()
    }
    
    override func setStyles() {
        self.view.backgroundColor = UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .light {
                return UIColor.white200
            } else {
                return UIColor.black100
            }
        }
        self.navigationController?.navigationBar.isHidden = true;
        
        setCollectionView()
    }
    
    override func setLayout() {
        self.view.addSubviews(segmentedControl, collectionView, bottomButtonView)
        
        segmentedControl.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(10)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(16)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(segmentedControl.snp.bottom).offset(27)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 578 / 874)
        }
        
        bottomButtonView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
    func setAddTarget() {
        bottomButtonView.getRightButton().addTarget(self, action: #selector(presentToPayViewController), for: .touchUpInside)
    }
    
    @objc
    func presentToPayViewController() {
        let vc = PayModalViewController()
        
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.custom(resolver: { context in
                return context.maximumDetentValue * 0.8445
            })]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }
        present(vc, animated: true, completion: nil)
    }
}

// MARK: - CollectionView Methods

private extension ViewController {
    func setCollectionView() {
        collectionView.backgroundColor = .clear
//        collectionView.alwaysBounceVertical = false
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        configureDataSource()
    }
    
    func configureDataSource() {
        // 테스트 코드
        var testIEProduct = [IEProduct]()
        for i in 1...17 {
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
        
        let firstPageItems = Array(testIEProduct.prefix(5))
        let otherPageItems = Array(testIEProduct.dropFirst(5))
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
        section.visibleItemsInvalidationHandler = { (item, offset, env) in
            let index = Int((offset.x / env.container.contentSize.width).rounded(.up))
            print(">>> \(index)")
        }
        
        return section
    }
}

// MARK: - UICollectionViewDelegate

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath) cell pressed.")
    }
}
