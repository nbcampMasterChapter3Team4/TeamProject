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


    // TODO: - 삭제하기

    private let demoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Demo", for: .normal)
        return button
    }()


    private let segmentedControl = UISegmentedControl().then {
        $0.backgroundColor = UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .light {
                return .gray80
            } else {
                return .gray600
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
                        return .black100
                    } else {
                        return .white200
                    }
                }], for: .normal)
    }
    
    private let productCollectionPageView = ProductCollectionPageView()
    
    private let bottomButtonView = CustomBottomButton().then {
        $0.configure("₩0", "결제하기")
    }
    
    // MARK: - Properties
    
    /// 테스트 용도
    private var testIEProduct = [IECategory: [IEProduct]]()
    private var testCartData = [IEProduct]()
    
    /// 장바구니
    private var shoppingCart = [IECartModel]()
    /// 모든 상품(IEProduct)에 대한 정보가 들어있는 딕셔너리
    private var productDict = [Int: IEProduct]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAddTarget()
        
        makeTestData()
        productCollectionPageView.setData(products: combineAllProduct(), animated: true)
        
        // Core Data 테스트
//        makeTestCartData()
        fetchCartData()
    }
    
    // MARK: - Style Helper
    
    override func setStyles() {
        self.view.backgroundColor = UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .light {
                return .white200
            } else {
                return .black100
            }
        }
        self.navigationController?.navigationBar.isHidden = true
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

        // TODO: - 모달 연결 임시 버튼 추후 삭제
               self.view.addSubview(demoButton)
               demoButton.snp.makeConstraints {
                   $0.top.equalTo(segmentedControl.snp.bottom).offset(28)
                   $0.centerX.equalTo(self.view.safeAreaLayoutGuide)
               }
               demoButton.addTarget(self, action: #selector(showDetailModal), for: .touchUpInside)

    }

    @objc private func showDetailModal() {
        let detailModalVC = DetailModalViewController()
        if let sheet = detailModalVC.sheetPresentationController {
            sheet.detents = [
                .custom { context in
                    return context.maximumDetentValue * 0.75
                }
            ]
            sheet.prefersGrabberVisible = true
        }
        self.present(detailModalVC, animated: true)
    }
    
    // MARK: - Methods
    
    private func setAddTarget() {
        segmentedControl.addTarget(self, action: #selector(didChangeValue(_:)), for: .valueChanged)
        bottomButtonView.getRightButton().addTarget(self, action: #selector(presentToPayViewController), for: .touchUpInside)
    }
    
    // MARK: - Test Methods
    
    /// 테스트 데이터 생성
    private func makeTestData() {
        for i in 0..<10 {
            let iPhone = IEProduct(
                id: i,
                name: "iPhone 16 Pro",
                imageName: "iPhone16Pro",
                price: 1_550_000,
                description: "궁극의 iPhone.",
                colors: [.desertTitanium],
                category: .iPhone
            )
            testIEProduct[.iPhone, default: []].append(iPhone)
        }
        for i in 10..<22 {
            let mac = IEProduct(
                id: i,
                name: "iMac",
                imageName: "iMac",
                price: 1_990_000,
                description: "창의적인 작업도 생산적 업무도 척척. 놀라운 올인원 데스크탑.",
                colors: [.blue],
                category: .mac
            )
            testIEProduct[.mac, default: []].append(mac)
        }
        for i in 22..<36 {
            let iPad = IEProduct(
                id: i,
                name: "iPad Pro",
                imageName: "iPadPro",
                price: 1_599_000,
                description: "최첨단 기술이 구현하는 궁극의 iPad 경험.",
                colors: [.silver],
                category: .iPad
            )
            testIEProduct[.iPad, default: []].append(iPad)
        }
        for i in 36..<52 {
            let acc = IEProduct(
                id: i,
                name: "MagSafe형 iPhone 16 Pro 실리콘 케이스",
                imageName: "MagSafeCase",
                price: 69_000,
                description: "",
                colors: [.aquamarine],
                category: .acc
            )
            testIEProduct[.acc, default: []].append(acc)
        }
    }
    
    /// 모든 제품 데이터 배열로 반환
    private func combineAllProduct() -> [IEProduct] {
        let allProduct = testIEProduct.flatMap { $0.value }
        return allProduct.shuffled()
    }
    
    /// 테스트 장바구니 데이터 생성
    private func makeTestCartData() {
        let iPhone = testIEProduct[.iPhone]!.first!
        let mac = testIEProduct[.mac]!.first!
        let iPad = testIEProduct[.iPad]!.first!
        let acc = testIEProduct[.acc]!.first!
        testCartData.append(contentsOf: [iPhone, mac, iPad, acc])
        
        for (i, data) in testCartData.enumerated() {
            guard let selectedColor = data.colors.first else { continue }
            let test = IECartModel(
                id: UUID(),
                productID: data.id,
                selectedColor: selectedColor,
                cartQuantity: i + 1
            )
            CoreDataManager.saveData(test)
        }
    }
    
    /// 장바구니 데이터 불러오기
    private func fetchCartData() {
        shoppingCart = CoreDataManager.fetchData()
        print(shoppingCart)
        
        var price = 0
        shoppingCart.forEach {
            price += productDict[$0.productID]?.price ?? 0
        }
        let priceStr = String(price)
        bottomButtonView.setPrice(priceStr.formattedPrice)
    }
    
    // MARK: - objc Methods
    
    @objc
    private func didChangeValue(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            productCollectionPageView.setData(products: combineAllProduct(), animated: false)
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
    private func presentToPayViewController() {
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
