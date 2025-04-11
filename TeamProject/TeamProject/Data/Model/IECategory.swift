//
//  IECategory.swift
//  TeamProject
//
//  Created by 서동환 on 4/8/25.
//

import Foundation

enum IECategory: CaseIterable {
    case all
    case iPhone
    case mac
    case iPad
    case acc
    
    var title: String {
        switch self {
        case .all:      return "All"
        case .iPhone:   return "iPhone"
        case .mac:      return "Mac"
        case .iPad:     return "iPad"
        case .acc:      return "ACC"
        }
    }
}
