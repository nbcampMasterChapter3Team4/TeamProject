//
//  PayModalViewController.swift
//  TeamProject
//
//  Created by 천성우 on 4/8/25.
//

import UIKit

import SnapKit
import Then

class PayModalViewController: BaseViewController {
    
    // 임시데이터
    private struct ShoppingItemModel {
        let image: UIImage
        let title: String
        let description: String
        let price: String
        let count: Int
    }

    // 임시데이터
    private var shoppingItemViews: [ShoppingItemView] = {
        let sampleItems: [ShoppingItemModel] = [
            ShoppingItemModel(image: UIImage(), title: "iPad Air", description: "최첨단 기술이 구현하는 궁극의 iPad 경험.", price: "1,900,000", count: 1),
            ShoppingItemModel(image: UIImage(), title: "iPhone 15", description: "놀라운 성능과 카메라.", price: "1,200,000", count: 1),
            ShoppingItemModel(image: UIImage(), title: "Apple Watch", description: "건강과 운동의 파트너.", price: "650,000", count: 1)
        ]
        
        return sampleItems.map { item in
            let view = ShoppingItemView()
            view.configure(item.image, item.title, item.description, item.price, item.count)
            return view
        }
    }()

    
    // MARK: - UI Components

    private let deleteButton = DeleteButton()
    private let popButton = UIButton().then {
        $0.setImage(ImageLiterals.iCon.close_button_lightMode_ic, for: .normal)
    }
    
    private let scrollView = UIScrollView()
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 26
        $0.alignment = .fill
        $0.distribution = .equalSpacing
    }
    
    private let bottomButtonView = CustomBottomButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBottomButton()
        setAddTarget()
        configureShoppingItems()
    }
    
    override func setStyles() {
        view.backgroundColor = .white200
    }
    
    override func setLayout() {
        view.addSubviews(deleteButton, popButton, scrollView, bottomButtonView)
        scrollView.addSubview(stackView)
        
        deleteButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.leading.equalToSuperview().offset(18)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 25 / 874)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 68 / 402)
        }
        
        popButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.width.equalTo(SizeLiterals.Screen.screenHeight * 30 / 874)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(deleteButton.snp.bottom).offset(26)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(bottomButtonView.snp.top)
        }
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(18)
            $0.width.equalTo(scrollView.snp.width).offset(-36)
        }
        
        
        bottomButtonView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
    private func setAddTarget() {
        deleteButton.addTarget(self, action: #selector(alertForDeleteAllItems), for: .touchUpInside)
        
        popButton.addTarget(self, action: #selector(popModal), for: .touchUpInside)
    }
    
    func setBottomButton() {
        bottomButtonView.configure("₩190,000", "결제하기")
    }
    
    private func configureShoppingItems() {
        for itemView in shoppingItemViews {
            itemView.snp.makeConstraints {
                $0.width.equalTo(SizeLiterals.Screen.screenWidth * 366 / 402)
                $0.height.equalTo(SizeLiterals.Screen.screenHeight * 99 / 874)
            }

            itemView.getItemCountStepper().addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)

            stackView.addArrangedSubview(itemView)
        }
    }

    
    private func alertForZeroItem(to titleLabel: String) {
        let alert = UIAlertController(title: "\(titleLabel)가 삭제됩니다.", message: "수량이 0입니다. 장바구니에서 삭제됩니다", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            print("alertForZeroItem 확인 버튼 눌림")
        }

        alert.addAction(okAction)

        present(alert, animated: true, completion: nil)
    }
    
    private func alertForOverItem() {
        let alert = UIAlertController(title: "상품을 추가할 수 없습니다.", message: "상품당 담을 수 있는 수량은 10개입니다", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            print("alertForOverItem 확인 버튼 눌림")
        }

        alert.addAction(okAction)

        present(alert, animated: true, completion: nil)
    }


    // MARK: - @objc Methods

    @objc
    private func stepperValueChanged(_ sender: UIStepper) {
        guard let index = shoppingItemViews.firstIndex(where: {
            $0.getItemCountStepper() === sender
        }) else { return }

        let itemView = shoppingItemViews[index]
        let currentValue = Int(sender.value)

        if currentValue == .zero {
            if let currentItemTitleLabel = itemView.getItemTitleLabel().text {
                alertForZeroItem(to: currentItemTitleLabel)
            }
        } else if currentValue > 10 {
            alertForOverItem()
        } else {
            itemView.getItemCountLabel().text = "\(currentValue)"
        }
    }


    @objc
    private func popModal() {
        dismiss(animated: true) {
            print("모달 닫힘")
        }
    }

    @objc
    private func alertForDeleteAllItems() {
        let alert = UIAlertController(title: "주문 내역을 모두 삭제하시겠습니까?", message: nil, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            print("alertForDeleteAllItems 확인 버튼 눌림")
            // TODO: 데이터 전체 삭제
        }

        let cancelAction = UIAlertAction(title: "취소", style: .destructive) { _ in
            print("alertForDeleteAllItems 취소 버튼 눌림")
        }
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}
