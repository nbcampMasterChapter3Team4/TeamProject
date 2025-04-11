//
//  IEColor.swift
//  TeamProject
//
//  Created by 서동환 on 4/8/25.
//

import UIKit

enum IEColor: String {
    case skyBlue = "SkyBlue"
    case silver = "Silver"
    case starlight = "Starlight"
    case midnight = "Midnight"
    case spaceBlack = "SpaceBlack"
    case blue = "Blue"
    case purple = "Purple"
    case pink = "Pink"
    case orange = "Orange"
    case yellow = "Yellow"
    case green = "Green"
    case spaceGray = "SpaceGray"
    case desertTitanium = "DesertTitanium"
    case naturalTitanium = "NaturalTitanium"
    case whiteTitanium = "WhiteTitanium"
    case blackTitanium = "BlackTitanium"
    case ultramarine = "Ultramarine"
    case teal = "Teal"
    case white = "White"
    case black = "Black"
    case periwinkle = "Periwinkle"
    case peony = "Peony"
    case aquamarine = "Aquamarine"
    case tangerine = "Tangerine"
    case starFruit = "StarFruit"
}

/// 해당 IEColor 케이스에 매칭되는 UIColor 반환

extension IEColor {
    var colorValue: UIColor {
        switch self {
        case .skyBlue:         return .skyBlue000
        case .silver:          return .silver000
        case .starlight:       return .starlight000
        case .midnight:        return .midnight000
        case .spaceBlack:      return .spaceBlack000
        case .blue:            return .blue000
        case .purple:          return .purple000
        case .pink:            return .pink000
        case .orange:          return .orange000
        case .yellow:          return .yellow000
        case .green:           return .green000
        case .spaceGray:       return .spaceGray000
        case .desertTitanium:  return .desertTitanium000
        case .naturalTitanium: return .naturalTitanium000
        case .whiteTitanium:   return .whiteTitanium000
        case .blackTitanium:   return .blackTitanium000
        case .ultramarine:     return .ultramarine000
        case .teal:            return .teal000
        case .white:           return .white000
        case .black:           return .black000
        case .periwinkle:      return .periwinkle000
        case .peony:           return .peony000
        case .aquamarine:      return .aquamarine000
        case .tangerine:       return .tangerine000
        case .starFruit:       return .starFruit000
        }
    }
}
