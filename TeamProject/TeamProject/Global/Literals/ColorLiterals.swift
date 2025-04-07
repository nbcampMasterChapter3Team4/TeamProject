//
//  ColorLiterals.swift
//  TeamProject
//
//  Created by 천성우 on 4/7/25.
//

import UIKit

extension UIColor {
    
    // MARK: - Black / White
    static var black100: UIColor { UIColor(hex: "#000000") }
    static var white200: UIColor { UIColor(hex: "#FFFFFF") }

    // MARK: - Gray
    static var gray50: UIColor { UIColor(hex: "#EFEFF0") }      // 라이트모드 +,- 버튼
    static var gray80: UIColor { UIColor(hex: "#EEEEEF") }      // 라이트모드 세그먼트 버튼
    static var gray100: UIColor { UIColor(hex: "#F2F2F2") }      // 라이트모드 셀 컬러
    static var gray200: UIColor { UIColor(hex: "#DEDEDE") }      // 라이트모드 모달 X 버튼
    static var gray400: UIColor { UIColor(hex: "#A6A6A9") }      // 라이트모드 아이템 페이지 버튼
    static var gray500: UIColor { UIColor(hex: "#858585") }      // 라이트모드 모달 X 버튼
    static var gray600: UIColor { UIColor(hex: "#313136") }      // 다크모드 세그먼트 버튼
    static var gray700: UIColor { UIColor(hex: "#2E3339") }      // 아이템 셀 컬러
    static var gray800: UIColor { UIColor(hex: "#27272A") }      // 다크모드 +,- 버튼
    static var gray900: UIColor { UIColor(hex: "#1C1C1E") }      // 다크모드 Modal 배경 색

    // MARK: - Red / Blue
    static var red300: UIColor { UIColor(hex: "#FF0000") }       // red 300
    static var blue200: UIColor { UIColor(hex: "#1974F9") }      // blue 200
}
