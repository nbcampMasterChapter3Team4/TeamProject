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
    case detailModalSteppers
    case detailModalQuantity
    
    // MARK: - PayModal
    case payModalItemTitle
    case payModalItemDesc
    case payModalDeleteLabel
    case payModalItemPrice
    case payModalEmptyLabel
}

extension FontLiterals {
    
    var size: CGFloat {
        switch self {
        case .new: return 8
            
        case .mainItemTitle: return 15
        case .mainItemPrice: return 8
        case .mainMiniItemTitle: return 10
        case .mainMiniItemPrice: return 8
        case .mainExpectationPriceTitle,
             .mainExpectationPriceValue,
             .mainCartOrPay: return 16
            
        case .detailModalItemTitle: return 18
        case .detailModalItemPrice: return 13
        case .detailModalSteppers: return 16
        case .detailModalQuantity: return 16
            
        case .payModalItemTitle: return 16
        case .payModalItemDesc: return 11
        case .payModalDeleteLabel: return 10
        case .payModalItemPrice: return 12
        case .payModalEmptyLabel: return 15
        }
    }
    
    var weight: UIFont.Weight {
        switch self {
        case .new: return .semibold
            
        case .mainItemTitle,
             .mainMiniItemTitle,
             .mainMiniItemPrice,
             .mainExpectationPriceTitle,
             .mainExpectationPriceValue,
             .mainCartOrPay,
             .detailModalItemTitle,
             .detailModalSteppers,
             .payModalEmptyLabel: return .bold
            
        case .mainItemPrice,
             .detailModalItemPrice,
             .payModalDeleteLabel: return .semibold
            
        case .payModalItemTitle,
             .payModalItemDesc,
             .payModalItemPrice: return .regular
            
        case .detailModalQuantity: return .medium
        }
    }
}

extension UIFont {
    static func fontGuide(_ font: FontLiterals) -> UIFont {
        return .systemFont(ofSize: font.size, weight: font.weight)
    }
}
