//
//  CustomBottomButton.swift
//  TeamProject
//
//  Created by 천성우 on 4/8/25.
//

import UIKit

import SnapKit
import Then

class CustomBottomButton: BaseView {
    
    // MARK: - UI Components

    private let leftButtonView = UIView().then {
        $0.roundCorners([.layerMinXMinYCorner], radius: 15)
        $0.backgroundColor = .gray700
    }
    
    private let leftButtonTitleLabel = UILabel().then {
        $0.text = "결제 예상금액"
        $0.textColor = .white200
        $0.font = .fontGuide(.mainExpectationPriceTitle)
    }
    
    private let leftButtonSubTitleLabel = UILabel().then {
        $0.textColor = .white200
        $0.font = .fontGuide(.mainExpectationPriceTitle)
    }

    private let rightButton = UIButton().then {
        $0.roundCorners(.layerMaxXMinYCorner, radius: 15)
        $0.backgroundColor = .blue200
        $0.titleLabel?.textColor = .white200
        $0.titleLabel?.font = .fontGuide(.mainExpectationPriceValue)
    }
    
    override func setStyles() {
        self.backgroundColor = .clear
    }
    
    
    // MARK: - Layout Helper
    
    override func setLayout() {
        addSubviews(leftButtonView, rightButton)
        leftButtonView.addSubviews(leftButtonTitleLabel, leftButtonSubTitleLabel)
        
        leftButtonView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 83 / 874)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 260 / 402)
        }
 
        rightButton.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.leading.equalTo(leftButtonView.snp.trailing)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 83 / 874)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 142 / 402)
        }
        
        leftButtonTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
        }
        
        leftButtonSubTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(leftButtonTitleLabel.snp.trailing).offset(9)
            $0.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
    /// 초기 각각의 Title을 set하기 위한 configure
    func configure(_ leftTitle: String, _ rightButtonTitle: String) {
        leftButtonSubTitleLabel.text = leftTitle
        rightButton.setTitle(rightButtonTitle, for: .normal)
    }
    
    /// rightButton에 접근하기 위한 func
    func getRightButton() -> UIButton {
        return rightButton
    }
    
    /// 금액 변동이 있을 때 해당 func를 호출
    func setPrice(_ price: String) {
        leftButtonSubTitleLabel.text = price
    }
}
