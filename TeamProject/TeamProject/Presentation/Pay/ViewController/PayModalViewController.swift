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
    
    // MARK: - UI Components

    private let deleteButton = DeleteButton()
    private let popButton = UIButton().then {
        $0.setImage(ImageLiterals.iCon.close_button_lightMode_ic, for: .normal)
    }
    
    private let testView = ShoppingItemView()
    
    private let bottomButtonView = CustomBottomButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBottomButton()
        setAddTarget()
    }
    
    override func setStyles() {
        view.backgroundColor = .white200
    }
    
    override func setLayout() {
        view.addSubviews(deleteButton, popButton, testView, bottomButtonView)
        
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
        
        testView.snp.makeConstraints {
            $0.top.equalTo(deleteButton.snp.bottom).offset(26)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 366 / 402)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 99 / 874)
        }
        
        bottomButtonView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
    func setAddTarget() {
        testView.getItemCountStepper().addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
    }
    
    func setBottomButton() {
        bottomButtonView.configure("₩190,000", "결제하기")
    }
    
    
    // MARK: - @objc Methods
    
    @objc
    private func stepperValueChanged(_ sender: UIStepper) {
        let currentValue = Int(sender.value)
        testView.getItemCountLabel().text = "\(currentValue)"
    }
}
