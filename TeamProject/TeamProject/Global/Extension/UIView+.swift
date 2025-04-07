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
}
