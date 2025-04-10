//
//  ShoppingItemView.swift
//  TeamProject
//
//  Created by 천성우 on 4/8/25.
//

import UIKit

import SnapKit
import Then

class ShoppingItemView: BaseView {
    
    // MARK: - UI Components
    
    private let itemImageView = UIImageView().then {
        $0.backgroundColor = .gray100
        $0.layer.cornerRadius = 6
    }
    
    private let itemTitleLabel = UILabel().then {
        $0.text = "iPad Air"
        $0.font = .fontGuide(.payModalItemTitle)
        $0.textColor = UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .light {
                return .black100
            } else {
                return .white200
            }
        }
            
    }
    
    private let itemDescriptionLabel = UILabel().then {
        $0.text = "최첨단 기술이 구현하는 궁극의 iPad 경험."
        $0.font = .fontGuide(.payModalItemDesc)
        $0.numberOfLines = 0
        $0.textColor = UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .light {
                return .black100
            } else {
                return .white200
            }
        }
    }
    
    private let itemPriceLabel = UILabel().then {
        $0.text = "₩1,900,000부터"
        $0.font = .fontGuide(.payModalItemPrice)
        $0.textColor = .gray400
    }
    
    private let itemCountLabel = UILabel().then {
        $0.textColor = UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .light {
                return .black100
            } else {
                return .white200
            }
        }
        $0.font = .fontGuide(.payModalItemDesc)
        $0.text = "1"
    }
    private let itemCountStepper = UIStepper().then {
        $0.minimumValue = 0
        $0.maximumValue = 11
        $0.stepValue = 1
        $0.value = 1
    }
    
    // MARK: - Style Helper
    
    override func setStyles() {
        backgroundColor = .clear
    }
    
    
    // MARK: - Layout Helper
    
    override func setLayout() {
        addSubviews(itemImageView, itemTitleLabel, itemDescriptionLabel,
                    itemPriceLabel, itemCountLabel, itemCountStepper)
        
        itemImageView.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 110 / 402)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 99 / 874)
        }
        
        itemTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(itemImageView.snp.trailing).offset(10)
        }
        
        itemDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(itemTitleLabel.snp.bottom).offset(6)
            $0.leading.equalTo(itemImageView.snp.trailing).offset(10)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 150 / 402)
        }
        
        itemPriceLabel.snp.makeConstraints {
            $0.leading.equalTo(itemImageView.snp.trailing).offset(11)
            $0.bottom.equalToSuperview()
        }
        
        itemCountLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.centerX.equalTo(itemCountStepper.snp.centerX)
        }
        
        itemCountStepper.snp.makeConstraints {
            $0.top.equalTo(itemCountLabel.snp.bottom).offset(10)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 30 / 874)
        }
    }
    
    // MARK: - Methods
    
    /// 초기 각각의 Title을 set하기 위한 configure
    func configure(_ image: UIImage, _ title: String, _ description: String, _ price: Int, _ itemCount: Int) {
        itemImageView.image = image
        itemTitleLabel.text = title
        itemDescriptionLabel.text = description
        itemPriceLabel.text = "₩\(price.formattedPrice)" // 1,000,000 변환 작업 필요
        itemCountLabel.text = "\(itemCount)"
    }
    
    /// PayModal VC에서 Stepper를 접근하기 위함
    func getItemCountStepper() -> UIStepper {
        return itemCountStepper
    }

    /// PayModal VC에서 itemCountLabel을 접근하기 위함
    func getItemCountLabel() -> UILabel {
        return itemCountLabel
    }
    
    func getItemTitleLabel() -> UILabel {
        return itemTitleLabel
    }
}
