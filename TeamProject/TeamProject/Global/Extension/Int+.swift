//
//  String+.swift
//  TeamProject
//
//  Created by yimkeul on 4/9/25.
//

import Foundation

extension Int {
    var formattedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
