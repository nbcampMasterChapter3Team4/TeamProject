//
//  UIStackView+.swift
//  TeamProject
//
//  Created by 천성우 on 4/7/25.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach {
            self.addArrangedSubview($0)
        }
    }
}
