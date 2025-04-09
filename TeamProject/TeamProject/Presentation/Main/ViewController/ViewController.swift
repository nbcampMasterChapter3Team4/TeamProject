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
    
    private let productCollectionPageView = ProductCollectionPageView()
    
    private let bottomButtonView = CustomBottomButton().then {
        $0.configure("₩190,000", "결제하기")
    }
    
    // MARK: - Properties
    
    /// 테스트 용도
    private var testIEProduct = [IECategory: [IEProduct]]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAddTarget()
        
        makeTestData()
        productCollectionPageView.setData(products: combineAllProduct(), animated: true)
    }
    
    // MARK: - Style Helper
    
    override func setStyles() {
        self.view.backgroundColor = UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .light {
                return UIColor.white200
            } else {
                return UIColor.black100
            }
        }
        self.navigationController?.navigationBar.isHidden = true;
    }
    
    // MARK: - Layout Helper
    
    override func setLayout() {
        self.view.addSubviews(segmentedControl, productCollectionPageView, bottomButtonView)
        
        segmentedControl.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(10)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(16)
        }
        
        productCollectionPageView.snp.makeConstraints {
            $0.top.equalTo(segmentedControl.snp.bottom).offset(27)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.bottom.equalTo(bottomButtonView.snp.top)
        }
        
        bottomButtonView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
    func setAddTarget() {
        segmentedControl.addTarget(self, action: #selector(didChangeValue(_:)), for: .valueChanged)
        bottomButtonView.getRightButton().addTarget(self, action: #selector(presentToPayViewController), for: .touchUpInside)
    }
    
    /// 테스트 데이터 생성
    private func makeTestData() {
        for i in 1...10 {
            let product = IEProduct(
                id: UUID(),
                name: "iPhone 16 Pro",
                imageName: "iPhone16Pro",
                price: 500_000 * i,
                description: "테스트",
                color: .desertTitanium,
                category: .iPhone
            )
            testIEProduct[.iPhone, default: []].append(product)
        }
        
        for i in 1...12 {
            let product = IEProduct(
                id: UUID(),
                name: "MacBook Pro",
                imageName: "MacBookPro",
                price: 500_000 * i,
                description: "테스트",
                color: .desertTitanium,
                category: .mac
            )
            testIEProduct[.mac, default: []].append(product)
        }
        
        for i in 1...14 {
            let product = IEProduct(
                id: UUID(),
                name: "iPad Pro",
                imageName: "iPadPro",
                price: 500_000 * i,
                description: "테스트",
                color: .desertTitanium,
                category: .iPad
            )
            testIEProduct[.iPad, default: []].append(product)
        }
        
        for i in 1...16 {
            let product = IEProduct(
                id: UUID(),
                name: "Apple Pencil Pro",
                imageName: "ApplePencilPro",
                price: 500_000 * i,
                description: "테스트",
                color: .desertTitanium,
                category: .acc
            )
            testIEProduct[.acc, default: []].append(product)
        }
    }
    
    private func combineAllProduct() -> [IEProduct] {
        var allProduct = [IEProduct]()
        testIEProduct.forEach {
            $0.value.forEach { product in
                allProduct.append(product)
            }
        }
        return allProduct.shuffled()
    }
    
    @objc
    private func didChangeValue(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            productCollectionPageView.setData(products: combineAllProduct(), animated: true)
        case 1:
            productCollectionPageView.setData(products: testIEProduct[.iPhone] ?? [], animated: false)
        case 2:
            productCollectionPageView.setData(products: testIEProduct[.mac] ?? [], animated: false)
        case 3:
            productCollectionPageView.setData(products: testIEProduct[.iPad] ?? [], animated: false)
        case 4:
            productCollectionPageView.setData(products: testIEProduct[.acc] ?? [], animated: false)
        default:
            productCollectionPageView.setData(products: testIEProduct[.iPhone] ?? [], animated: false)
        }
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
