//
//  MiniItemCell.swift
//  TeamProject
//
//  Created by 서동환 on 4/8/25.
//

import UIKit

class MiniItemCell: UICollectionViewCell {
    
    // MARK: - UI Component
    
    private let miniItemTitleLabel = UILabel().then {
        $0.text = "iPhone 16 Pro"
        $0.textColor = UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .light {
                return UIColor.black100
            } else {
                return UIColor.white200
            }
        }
        $0.font = .fontGuide(.mainMiniItemTitle)
    }
    
    private let miniItemImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 10
    }
    
    private let miniItemPriceLabel = UILabel().then {
        $0.text = "₩1,550,000부터"
        $0.textColor = UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .light {
                return UIColor.gray400
            } else {
                return UIColor.blue200
            }
        }
        $0.font = .fontGuide(.mainMiniItemPrice)
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyles()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStyles() {
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .light {
                return UIColor.gray100
            } else {
                return UIColor.gray700
            }
        }
    }
    
    private func setLayout() {
        self.addSubviews(miniItemTitleLabel, miniItemImageView, miniItemPriceLabel)
        
        let screenWidth = SizeLiterals.Screen.screenWidth
        let screenHeight = SizeLiterals.Screen.screenHeight
        let isSmallDevice = min(screenWidth, screenHeight) <= 375
        
        miniItemTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(10)
        }
        
        miniItemImageView.snp.makeConstraints {
            $0.top.equalTo(miniItemTitleLabel.snp.bottom).offset(isSmallDevice ? 2 : 5)
            $0.height.equalToSuperview().multipliedBy(isSmallDevice ? 0.6 : 0.65)
            $0.centerX.equalToSuperview()
        }
        
        miniItemPriceLabel.snp.makeConstraints {
            $0.leading.equalTo(miniItemTitleLabel)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
    
    func configure(title: String, image: UIImage?, price: Int) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let priceStr = numberFormatter.string(for: price) ?? "1,550,000"
        
        miniItemTitleLabel.text = title
        miniItemImageView.image = image
        miniItemPriceLabel.text = "₩\(priceStr)부터"
    }
}
