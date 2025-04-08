//
//  BestItemView.swift
//  TeamProject
//
//  Created by 서동환 on 4/8/25.
//

import UIKit

class BestItemView: UICollectionReusableView {
    static let identifier = "BestItemView"
    
    // MARK: - UI Components
    
    private let bestTitleLabel = UILabel().then {
        $0.text = "NEW"
        $0.textColor = .red300
        $0.font = .fontGuide(.new)
    }
    
    private let bestItemTitleLabel = UILabel().then {
        $0.font = .fontGuide(.mainItemTitle)
    }
    
    private let bestItemImageView = UIImageView().then {
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 10
    }
    
    private let bestItemPriceLabel = UILabel().then {
        $0.font = .fontGuide(.mainItemPrice)
    }
    
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
        
    }
}
