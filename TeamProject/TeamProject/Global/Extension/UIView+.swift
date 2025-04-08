//
//  UIView.swift
//  TeamProject
//
//  Created by 천성우 on 4/7/25.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach {
            self.addSubview($0)
        }
    }
    
    /// 특정 모서리에만 cornerRadius를 적용
    /// 사용 예시:
    /// let myView = UIView().then {
    ///     $0.roundCorners([.layerMinXMinYCorner, .layerMinXMaxYCorner], radius: 10)
    /// }
    /// → 왼쪽 위, 왼쪽 아래 모서리만 둥글게

    /// 왼쪽 위  .layerMinXMinYCorner, 오른쪽 위 .layerMaxXMinYCorner
    /// 왼쪽 아래 .layerMinXMaxYCorner, 오른쪽 아래 .layerMaxXMaxYCorner

    func roundCorners(_ corners: CACornerMask, radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corners
        self.clipsToBounds = true
    }
}
