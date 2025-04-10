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

    private var cartModels: [IECartModel] = []
    private var shoppingItems: [ShoppingItemModel] = []
    private var shoppingItemViews: [ShoppingItemView] = []
    
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
    
    private let bottomButtonView = CustomBottomButton().then {
        $0.configure("₩0", "장바구니(0)")
    }

    private let emptyStateView = ShoppingItemEmptyView()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setAddTarget()
        cartModels = CoreDataManager.fetchData()
        updateShoppingItemViews()
        configureShoppingItems()
        
    }

    // 화면 모드 변환 탐지
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        // 이전과 현재 모드가 다를 때만 이미지 갱신
        if previousTraitCollection?.userInterfaceStyle != traitCollection.userInterfaceStyle {
            popButton.setImage(traitCollection.userInterfaceStyle == .light ?
                ImageLiterals.iCon.close_button_lightMode_ic:
                    ImageLiterals.iCon.close_button_darkMode_ic
                , for: .normal)
        }
    }

    // MARK: - Style Helper

    override func setStyles() {
        view.backgroundColor = UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .light {
                return .white200
            } else {
                return .gray900
            }
        }
    }
    
    // MARK: - Layout Helper

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

    // MARK: - Update Methods
    
    
    // MARK: - Update EmptyView Method
    
    private func updateEmptyStateView() {
        emptyStateView.isHidden = !shoppingItemViews.isEmpty
        scrollView.isHidden = shoppingItemViews.isEmpty
        deleteButton.isHidden = shoppingItemViews.isEmpty
    }

    // MARK: - Update About ShoppintgItems Method
    
    private func updateShoppingItems() {
        shoppingItems = cartModels.compactMap { cartModel in
            if let dataIndex = products.firstIndex(where: { $0.id == cartModel.productID }) {
                let data = products[dataIndex]
                if let image = UIImage(named: data.imageName) {
                    return ShoppingItemModel(
                        id: cartModel.id,
                        image: image,
                        title: data.name,
                        description: data.description,
                        price: data.price,
                        count: cartModel.cartQuantity,
                        color: cartModel.selectedColor
                    )
                }
            }
            return nil
        }
        _ = shoppingItems.map { print($0) }
    }

    private func updateShoppingItemViews() {
        
        updateShoppingItems()
        
        shoppingItemViews = shoppingItems.map { item in
            let view = ShoppingItemView()
            view.configure(item.image, item.title, item.description, item.price, item.count)
            return view
        }
    }
    
    
    // MARK: - RemoveItem Methods

    private func removeItemView(at index: Int, from id: UUID) {
        let itemView = shoppingItemViews[index]
        stackView.removeArrangedSubview(itemView)
        itemView.removeFromSuperview()
        shoppingItemViews.remove(at: index)
        CoreDataManager.deleteData(id: id)
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

    private func alertForZeroItem(to titleLabel: String, for index: Int, from id: UUID, stepper: UIStepper) {
        let okAction = makeAlertAction(title: "확인", style: .default) { _ in
            print("alertForZeroItem 확인 버튼 눌림")
            self.removeItemView(at: index, from: id)
            // Noti 추가
            NotificationCenter.default.post(
                name: NSNotification.Name("ModalDismissNC"),
                object: nil,
                userInfo: nil
            )
        }

        let cancelAction = makeAlertAction(title: "취소", style: .destructive) { _ in
            print("alertForZeroItem 취소 버튼 눌림")
            stepper.value = 1
            self.shoppingItemViews[index].getItemCountLabel().text = "수량: 1개"
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
            self.shoppingItemViews[index].getItemCountLabel().text = "수량: 10개"
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
                alertForZeroItem(to: currentItemTitleLabel, for: index, from: shoppingItems[index].id, stepper: sender)
            }
        } else if currentValue > 10 {
            alertForOverItem(for: index, stepper: sender)
        } else {
            itemView.getItemCountLabel().text = "수량: \(currentValue)개"
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
            // Noti 추가
            NotificationCenter.default.post(
                name: NSNotification.Name("ModalDismissNC"),
                object: nil,
                userInfo: nil
            )
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
