//
//  ViewController.swift
//  TeamProject
//
//  Created by 서동환 on 4/4/25.
//

import UIKit

import SnapKit
import Then

final class ViewController: BaseViewController {
        
    // MARK: - UI Components


    // TODO: - 삭제하기

    private let demoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Demo", for: .normal)
        return button
    }()
    
    private let segmentedControl = UISegmentedControl(
        items: IECategory.allCases.map { $0.title }).then {
            $0.backgroundColor = UIColor { traitCollection in
                if traitCollection.userInterfaceStyle == .light {
                    return .gray80
                } else {
                    return .gray600
                }
            }
            $0.setTitleTextAttributes(
                [.foregroundColor:
                    UIColor { traitCollection in
                        if traitCollection.userInterfaceStyle == .light {
                            return .black100
                        } else {
                            return .white200
                        }
                    }], for: .normal)
            $0.selectedSegmentIndex = 0
        }
    
    private let productCollectionPageView = ProductCollectionPageView()
    
    private let bottomButtonView = CustomBottomButton().then {
        $0.configure("₩0", "장바구니(0)")
    }
    
    // MARK: - Properties
    
    /// 상품 데이터
    private var appleProducts = products
    
    /// 장바구니
    private var shoppingCart = [IECartModel]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAddTarget()
        setNotificationCenter()
        
        productCollectionPageView.setData(allProducts: appleProducts, animated: true)
        
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
    
    private func setNotificationCenter() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didDismissDetailNotification(_:)),
            name: NSNotification.Name("ModalDismissNC"),
            object: nil
        )
        
        // TODO: - 아래 코드 Detail, Pay 모달 뷰 컨트롤러의 viewWillDisappear에 추가
//        NotificationCenter.default.post(
//            name: NSNotification.Name("ModalDismissNC"),
//            object: nil,
//            userInfo: nil
//        )
    }
    
    // MARK: - Test Methods
    
    /// 테스트 장바구니 데이터 생성
    private func makeTestCartData() {
        let iPhone = appleProducts.filter { $0.category == .iPhone }.first!
        let mac = appleProducts.filter { $0.category == .mac }.first!
        let iPad = appleProducts.filter { $0.category == .iPad }.first!
        let acc = appleProducts.filter { $0.category == .acc }.first!
        let testCartData = [iPhone, mac, iPad, acc]
        
        for (i, data) in testCartData.enumerated() {
            // 임시로 첫번째 컬러 선택
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
        shoppingCart.forEach { price += appleProducts[$0.productID].price }
        bottomButtonView.setPrice("₩\(price.formattedPrice)")
        bottomButtonView.getRightButton().setTitle("장바구니(\(shoppingCart.count))", for: .normal)
    }
    
    // MARK: - objc Methods
    
    @objc
    private func didChangeValue(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            productCollectionPageView.setData(allProducts: appleProducts, animated: false)
        } else {
            let showProducts = appleProducts.filter { $0.category == IECategory.allCases[sender.selectedSegmentIndex] }
            productCollectionPageView.setData(allProducts: showProducts, animated: false)
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
    
    @objc
    private func didDismissDetailNotification(_ notification: Notification) {
        fetchCartData()
    }
}
