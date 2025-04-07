//
//  FontLiterals.swift
//  TeamProject
//
//  Created by 천성우 on 4/7/25.
//

import UIKit

enum FontLiterals {
    
    // MARK: - NEW
    case new
    
    // MARK: - Main
    case mainItemTitle
    case mainItemPrice
    case mainMiniItemTitle
    case mainMiniItemPrice
    case mainExpectationPriceTitle
    case mainExpectationPriceValue
    case mainCartOrPay
    
    // MARK: - DetailModal
    case detailModalItemTitle
    case detailModalItemPrice
    
    // MARK: - PayModal
    case payModalItemTitle
    case payModalItemDesc
}

extension FontLiterals {
    
    var size: CGFloat {
        switch self {
        case .new: return 8
            
        case .mainItemTitle: return 15
        case .mainItemPrice: return 8
        case .mainMiniItemTitle: return 8
        case .mainMiniItemPrice: return 6
        case .mainExpectationPriceTitle,
             .mainExpectationPriceValue,
             .mainCartOrPay: return 16
            
        case .detailModalItemTitle: return 15
        case .detailModalItemPrice: return 10
            
        case .payModalItemTitle: return 20
        case .payModalItemDesc: return 14
        }
    }
    
    var weight: UIFont.Weight {
        switch self {
        case .new: return .semibold
            
        case .mainItemTitle,
             .mainExpectationPriceTitle,
             .mainExpectationPriceValue,
             .mainCartOrPay,
             .detailModalItemTitle: return .bold
            
        case .mainItemPrice,
             .detailModalItemPrice: return .semibold
            
        case .mainMiniItemTitle,
             .mainMiniItemPrice,
             .payModalItemTitle,
             .payModalItemDesc: return .regular
        }
    }
}

extension UIFont {
    static func fontGuide(_ font: FontLiterals) -> UIFont {
        return .systemFont(ofSize: font.size, weight: font.weight)
    }
}
