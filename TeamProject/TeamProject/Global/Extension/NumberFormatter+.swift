//
//  NumberFormatter+.swift
//  TeamProject
//
//  Created by 서동환 on 4/9/25.
//

import Foundation

extension NumberFormatter {
    static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        return formatter
    }()
    
    static func getNumberFormatter() -> NumberFormatter {
        return numberFormatter
    }
}
