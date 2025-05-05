//
//  ShoppingItemEmptyView.swift
//  TeamProject
//
//  Created by yimkeul on 4/10/25.
//

import UIKit

import SnapKit
import Then

class ShoppingItemEmptyView: BaseView {
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel().then {
        $0.text = "장바구니에 담은 상품이 없습니다."
        $0.textAlignment = .center
        $0.font = .fontGuide(.payModalEmptyLabel)
        $0.textColor = .gray400
    }
    
    private let appleLogoImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = ImageLiterals.iCon.apple_ic
    }
    
    
    //MARK: Style Helper
    
    override func setStyles() {
        backgroundColor = .clear
    }
    
    // MARK: Layout Helper
    
    override func setLayout() {
        addSubviews(appleLogoImageView, titleLabel)
        
        appleLogoImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 100 / 874)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 100 / 402)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(appleLogoImageView.snp.bottom).offset(22)
            $0.centerX.equalToSuperview()
        }
    }
    
    func getTitleLabel() -> UILabel {
        return titleLabel
    }
    
    func getImageView() -> UIImageView {
        return appleLogoImageView
    }
}
