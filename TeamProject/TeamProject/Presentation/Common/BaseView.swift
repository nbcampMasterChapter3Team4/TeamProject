//
//  BaseView.swift
//  TeamProject
//
//  Created by 천성우 on 4/7/25.
//

import UIKit

import SnapKit
import Then

class BaseView: UIView {
    
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
    
    /// View 의 Style 을 set 합니다.
    func setStyles() {}
    /// View 의 Layout 을 set 합니다.
    func setLayout() {}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
