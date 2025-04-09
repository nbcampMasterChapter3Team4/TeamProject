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
    
    // MARK: - Style Helper
    
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
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        self.addSubviews(miniItemTitleLabel, miniItemImageView, miniItemPriceLabel)

        miniItemTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(10)
        }
        
//        miniItemImageView.snp.makeConstraints {
//            $0.width.equalTo(miniItemImageView.snp.height).multipliedBy(1)
//            $0.height.equalToSuperview().multipliedBy(0.6)
//            $0.centerX.centerY.equalToSuperview()
//        }
        
        miniItemPriceLabel.snp.makeConstraints {
            $0.leading.equalTo(miniItemTitleLabel)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
    
    // MARK: - Methods
    
    func configure(title: String, image: UIImage?, price: Int) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let priceStr = numberFormatter.string(for: price) ?? "1,550,000"
        
        miniItemTitleLabel.text = title
        miniItemImageView.image = image
        miniItemPriceLabel.text = "₩\(priceStr)부터"
        
        // miniItemImageView에 image가 반영되었을 때 레이아웃 설정
        // - 이미지가 작게 보이는 문제 해결
        miniItemImageView.snp.makeConstraints {
            let screenWidth = SizeLiterals.Screen.screenWidth
            let screenHeight = SizeLiterals.Screen.screenHeight
            let isSmallDevice = min(screenWidth, screenHeight) <= 375
            
            let imageSize = miniItemImageView.image?.size
            if imageSize?.width ?? 0 >= imageSize?.height ?? 0 {
                // 너비가 길면 너비 기준 높이 설정
                $0.width.equalToSuperview().multipliedBy(isSmallDevice ? 0.6 : 0.65)
                $0.height.equalTo(miniItemImageView.snp.width).multipliedBy(1)
            } else {
                // 높이가 길면 높이 기준 너비 설정
                $0.height.equalToSuperview().multipliedBy(isSmallDevice ? 0.55 : 0.60)
                $0.width.equalTo(miniItemImageView.snp.height).multipliedBy(1)
            }
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
