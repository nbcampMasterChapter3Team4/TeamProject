//
//  BaseCollectionViewCell.swift
//  TeamProject
//
//  Created by 서동환 on 4/9/25.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    private lazy var viewName = self.className
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyles()
        setLayout()
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        print("🧵 \(viewName) has been successfully Removed")
    }
    
    /// Cell 의 Style 을 set 합니다.
    func setStyles() {
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .light {
                return .gray100
            } else {
                return .gray700
            }
        }
    }
    /// Cell 의 Layout 을 set 합니다.
    func setLayout() {}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
