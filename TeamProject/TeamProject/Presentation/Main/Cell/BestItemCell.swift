//
//  BestItemCell.swift
//  TeamProject
//
//  Created by 서동환 on 4/8/25.
//

import UIKit

class BestItemCell: UICollectionViewCell {
    static let reuseIdentifier = "BestItemCell"
    
    // MARK: - UI Components
    
    private let bestTitleLabel = UILabel().then {
        $0.text = "NEW"
        $0.textColor = .red300
        $0.font = .fontGuide(.new)
    }
    
    private let bestItemTitleLabel = UILabel().then {
        $0.text = "iPhone 16 Pro"
        $0.textColor = UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .light {
                return UIColor.black100
            } else {
                return UIColor.white200
            }
        }
        $0.font = .fontGuide(.mainItemTitle)
    }
    
    private let bestItemImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 10
    }
    
    private let bestItemPriceLabel = UILabel().then {
        $0.text = "₩1,550,000부터 "
        $0.textColor = UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .light {
                return UIColor.gray400
            } else {
                return UIColor.blue200
            }
        }
        $0.font = .fontGuide(.mainItemPrice)
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
        self.addSubviews(bestTitleLabel, bestItemTitleLabel, bestItemImageView, bestItemPriceLabel)
        
        let screenWidth = SizeLiterals.Screen.screenWidth
        let screenHeight = SizeLiterals.Screen.screenHeight
        let isSmallDevice = min(screenWidth, screenHeight) <= 375
        
        bestTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.leading.equalToSuperview().inset(15)
        }
        
        bestItemTitleLabel.snp.makeConstraints {
            $0.top.equalTo(bestTitleLabel.snp.bottom).offset(2)
            $0.leading.equalTo(bestTitleLabel)
        }
        
        bestItemImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.trailing.equalToSuperview().inset(10)
            $0.width.equalTo(bestItemImageView.snp.height).multipliedBy(1)
            $0.height.equalToSuperview().multipliedBy(isSmallDevice ? 0.75 : 0.8)
        }
        
        bestItemPriceLabel.snp.makeConstraints {
            $0.leading.equalTo(bestTitleLabel)
            $0.bottom.equalToSuperview().inset(15)
        }
    }
    
    // MARK: - Methods
    
    func configure(title: String, image: UIImage?, price: Int) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let priceStr = numberFormatter.string(for: price) ?? "1,550,000"
        
        bestItemTitleLabel.text = title
        bestItemImageView.image = image
        bestItemPriceLabel.text = "₩\(priceStr)부터"
    }
}
