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
        let price: Int
        let count: Int
    }

    // 임시데이터
    private var shoppingItemViews: [ShoppingItemView] = {
        let sampleItems: [ShoppingItemModel] = [
            ShoppingItemModel(image: UIImage(), title: "iPad Air", description: "최첨단 기술이 구현하는 궁극의 iPad 경험.", price: 1900000, count: 1),
            ShoppingItemModel(image: UIImage(), title: "iPhone 15", description: "놀라운 성능과 카메라.", price: 1200000, count: 1),
            ShoppingItemModel(image: UIImage(), title: "Apple Watch", description: "건강과 운동의 파트너.", price: 650000, count: 1)
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
        $0.setImage(
            UITraitCollection.current.userInterfaceStyle == .light ?
            ImageLiterals.iCon.close_button_lightMode_ic:
                ImageLiterals.iCon.close_button_darkMode_ic,
            for: .normal
        )
    }

    private let scrollView = UIScrollView()

    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 26
        $0.alignment = .fill
        $0.distribution = .equalSpacing
    }

    private let bottomButtonView = CustomBottomButton()

    // TODO: 따로 View로 생성하거나 이미지 추가로 넣는 방법 고려
    private let emptyStateView = ShoppingItemEmptyView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setBottomButton()
        setAddTarget()
        configureShoppingItems()
    }

    // 화면 모드 변환 탐지
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        // 이전과 현재 모드가 다를 때만 이미지 갱신
        if previousTraitCollection?.userInterfaceStyle != traitCollection.userInterfaceStyle {
            popButton.setImage(traitCollection.userInterfaceStyle == .light ?
                ImageLiterals.iCon.close_button_lightMode_ic :
                ImageLiterals.iCon.close_button_darkMode_ic
                , for: .normal)
        }
    }

    override func setStyles() {
        view.backgroundColor = UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .light {
                return .white200
            } else {
                return .gray900
            }
        }
    }

    override func setLayout() {
        view.addSubviews(deleteButton, popButton, scrollView, bottomButtonView, emptyStateView)
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

        emptyStateView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(225)
        }

    }

    // MARK: - Methods

    private func setAddTarget() {
        deleteButton.addTarget(self, action: #selector(alertForDeleteAllItems), for: .touchUpInside)

        popButton.addTarget(self, action: #selector(popModal), for: .touchUpInside)
    }

    
    // TODO: 수정해야함. 가격 부분을 CoreData에서 받아온걸 계산해서 넣어야함.
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
        updateEmptyStateView()
    }

    private func updateEmptyStateView() {
        emptyStateView.isHidden = !shoppingItemViews.isEmpty
        scrollView.isHidden = shoppingItemViews.isEmpty
        deleteButton.isHidden = shoppingItemViews.isEmpty
    }


    // MARK: - RemoveItem Methods

    private func removeItemView(at index: Int) {
        let itemView = shoppingItemViews[index]
        stackView.removeArrangedSubview(itemView)
        itemView.removeFromSuperview()
        shoppingItemViews.remove(at: index)
        updateEmptyStateView()
    }

    private func removeAllItems() {
        for itemView in shoppingItemViews {
            stackView.removeArrangedSubview(itemView)
            itemView.removeFromSuperview()
        }
        shoppingItemViews.removeAll()
        updateEmptyStateView()
    }

    // MARK: - Alert Methods

    private func alertForZeroItem(to titleLabel: String, for index: Int, stepper: UIStepper) {
        let okAction = makeAlertAction(title: "확인", style: .default) { _ in
            print("alertForZeroItem 확인 버튼 눌림")
            self.removeItemView(at: index)
        }

        let cancelAction = makeAlertAction(title: "취소", style: .destructive) { _ in
            print("alertForZeroItem 취소 버튼 눌림")
            stepper.value = 1
            self.shoppingItemViews[index].getItemCountLabel().text = "1"
        }

        showAlert(
            title: "\(titleLabel)가 삭제됩니다.",
            message: "장바구니에서 이 항목을 제거하시겠습니까?",
            actions: [okAction, cancelAction]
        )
    }


    private func alertForOverItem(for index: Int, stepper: UIStepper) {
        let okAction = makeAlertAction(title: "확인") { _ in
            print("alertForOverItem 확인 버튼 눌림")
            stepper.value = 10
            self.shoppingItemViews[index].getItemCountLabel().text = "10"
        }

        showAlert(
            title: "상품을 추가할 수 없습니다.",
            message: "상품당 담을 수 있는 수량은 10개입니다",
            actions: [okAction]
        )
    }



    // MARK: - @objc Methods

    // TODO: 계산식 들어가야함.
    @objc
    private func stepperValueChanged(_ sender: UIStepper) {
        guard let index = shoppingItemViews.firstIndex(where: {
            $0.getItemCountStepper() === sender
        }) else { return }

        let itemView = shoppingItemViews[index]
        let currentValue = Int(sender.value)

        if currentValue == .zero {
            if let currentItemTitleLabel = itemView.getItemTitleLabel().text {
                alertForZeroItem(to: currentItemTitleLabel, for: index, stepper: sender)
            }
        } else if currentValue > 10 {
            alertForOverItem(for: index, stepper: sender)
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
        let okAction = makeAlertAction(title: "확인", style: .default) { _ in
            print("alertForDeleteAllItems 확인 버튼 눌림")
            self.removeAllItems()
            self.updateEmptyStateView()
            CoreDataManager.deleteAllData()
        }

        let cancelAction = makeAlertAction(title: "취소", style: .destructive) { _ in
            print("alertForDeleteAllItems 취소 버튼 눌림")
        }

        showAlert(
            title: "주문 내역을 모두 삭제하시겠습니까?",
            message: nil,
            actions: [okAction, cancelAction]
        )
    }
}
