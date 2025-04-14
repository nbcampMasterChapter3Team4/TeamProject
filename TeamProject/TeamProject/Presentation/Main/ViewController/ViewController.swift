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
    
    private let segmentedControl = UISegmentedControl(
        items: IECategory.allCases.map { $0.title }).then {
            $0.backgroundColor = UIColor { traitCollection in
                if traitCollection.userInterfaceStyle == .light {
                    return .gray80
                } else {
                    return .gray600
                }
            }
            $0.selectedSegmentTintColor = UIColor { traitCollection in
                if traitCollection.userInterfaceStyle == .light {
                    return .white200
                } else {
                    return .blue200
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
            $0.setTitleTextAttributes(
                [.foregroundColor:
                    UIColor { traitCollection in
                        if traitCollection.userInterfaceStyle == .light {
                            return .blue200
                        } else {
                            return .white200
                        }
                    }], for: .selected)
            $0.selectedSegmentIndex = 0
        }
    
    private let productCollectionPageView = ProductCollectionPageView()
    
    private let bottomButtonView = CustomBottomButton().then {
        $0.configure("₩0", "장바구니(0)")
    }
    
    // MARK: - Properties
    
    /// 상품 데이터[id: IEProduct]
    private var appleProducts = [Int: IEProduct]()
    /// id순으로 정렬된 상품 데이터
    private var sortedProducts = [IEProduct]()
    
    /// 장바구니
    private var shoppingCart = [IECartModel]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAddTarget()
        setNotificationCenter()
        
        products.forEach { appleProducts[$0.id] = $0 }
        sortedProducts = appleProducts.values.sorted(by: { $0.id < $1.id })
        
        productCollectionPageView.collectionView.delegate = self
        productCollectionPageView.setData(allProducts: sortedProducts, animated: true)
        
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
    }
    
    // MARK: - Test Methods
    
    /// 테스트 장바구니 데이터 생성
    private func makeTestCartData() {
        let iPhone = sortedProducts.filter { $0.category == .iPhone }.first!
        let mac = sortedProducts.filter { $0.category == .mac }.first!
        let iPad = sortedProducts.filter { $0.category == .iPad }.first!
        let acc = sortedProducts.filter { $0.category == .acc }.first!
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
        shoppingCart.forEach {
            guard let product = appleProducts[$0.productID] else { return }
            price += product.price * $0.cartQuantity
        }
        bottomButtonView.setPrice("₩\(price.formattedPrice)")
        bottomButtonView.getRightButton().setTitle("장바구니(\(shoppingCart.count))", for: .normal)
    }
    
    // MARK: - objc Methods
    
    @objc
    private func didChangeValue(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            productCollectionPageView.setData(allProducts: sortedProducts, animated: false)
        } else {
            let filteredProducts = sortedProducts.filter { $0.category == IECategory.allCases[sender.selectedSegmentIndex] }
            productCollectionPageView.setData(allProducts: filteredProducts, animated: false)
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

// MARK: - UICollectionViewDelegate

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = productCollectionPageView.sectionItems[indexPath.section][indexPath.item]
        print(selectedItem)

        // 모달 뷰 컨트롤러 생성 및 데이터 전달
        let detailModalVC = DetailModalViewController()
        detailModalVC.detailData = selectedItem
        
        let isSmallDevice = SizeLiterals.Screen.isSmallDevice
        if let sheet = detailModalVC.sheetPresentationController {
            sheet.detents = [
                .custom { context in
                    return context.maximumDetentValue * (isSmallDevice ? 0.95 : 0.75)
                }
            ]
            
            sheet.prefersGrabberVisible = true
        }
        present(detailModalVC, animated: true, completion: nil)
    }
}
