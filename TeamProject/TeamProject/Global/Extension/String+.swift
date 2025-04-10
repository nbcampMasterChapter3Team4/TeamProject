//
//  String+.swift
//  TeamProject
//
//  Created by yimkeul on 4/9/25.
//

import Foundation

extension String {
    var formattedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        if let number = Int(self) {
            return formatter.string(from: NSNumber(value: number)) ?? self
        }
        return self
    }
}
