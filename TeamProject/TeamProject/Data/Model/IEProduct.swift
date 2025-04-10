//
//  IEProduct.swift
//  TeamProject
//
//  Created by 서동환 on 4/8/25.
//

import UIKit

struct IEProduct: Hashable {
    let id: Int
    let name: String
    var imageName: String
    var price: Int
    var description: String
    var colors: [IEColor]
    var category: IECategory
    
    var productImage: UIImage? {
        switch imageName {
            
        // Main
        case "AirPodsMax": return ImageLiterals.Main.airPodsMax
        case "AirPodsPro2": return ImageLiterals.Main.airPodsPro2
        case "ApplePencilPro": return ImageLiterals.Main.applePencilPro
        case "iMac": return ImageLiterals.Main.iMac
        case "iPad": return ImageLiterals.Main.iPad
        case "iPadAir": return ImageLiterals.Main.iPadAir
        case "iPadMini": return ImageLiterals.Main.iPadMini
        case "iPadPro": return ImageLiterals.Main.iPadPro
        case "iPhone15": return ImageLiterals.Main.iPhone15
        case "iPhone16": return ImageLiterals.Main.iPhone16
        case "iPhone16e": return ImageLiterals.Main.iPhone16e
        case "iPhone16Pro": return ImageLiterals.Main.iPhone16Pro
        case "MacBookAir": return ImageLiterals.Main.macBookAir
        case "MacBookPro": return ImageLiterals.Main.macBookPro
        case "MacMini": return ImageLiterals.Main.macMini
        case "MacPro": return ImageLiterals.Main.macPro
        case "MacStudio": return ImageLiterals.Main.macStudio
        case "MagicKeyboard": return ImageLiterals.Main.magicKeyboard
        case "MagicMouse": return ImageLiterals.Main.magicMouse
        case "MagicTrackpad": return ImageLiterals.Main.magicTrackpad
        case "MagSafeCase": return ImageLiterals.Main.magSafeCase
        case "ProDisplayXDR": return ImageLiterals.Main.proDisplayXDR
        case "StudioDisplay": return ImageLiterals.Main.studioDisplay

        // Detail
        case "AirPodsMax_Blue": return ImageLiterals.Detail.airPodsMax_Blue
        case "AirPodsMax_Midnight": return ImageLiterals.Detail.airPodsMax_Midnight
        case "AirPodsMax_Orange": return ImageLiterals.Detail.airPodsMax_Orange
        case "AirPodsMax_Purple": return ImageLiterals.Detail.airPodsMax_Purple
        case "AirPodsMax_Starlight": return ImageLiterals.Detail.airPodsMax_Starlight
        case "AirPodsPro2_White": return ImageLiterals.Detail.airPodsPro2_White
        case "ApplePencilPro_White": return ImageLiterals.Detail.applePencilPro_White
        case "iMac_Blue": return ImageLiterals.Detail.iMac_Blue
        case "iMac_Green": return ImageLiterals.Detail.iMac_Green
        case "iMac_Orange": return ImageLiterals.Detail.iMac_Orange
        case "iMac_Pink": return ImageLiterals.Detail.iMac_Pink
        case "iMac_Purple": return ImageLiterals.Detail.iMac_Purple
        case "iMac_Silver": return ImageLiterals.Detail.iMac_Silver
        case "iMac_Yellow": return ImageLiterals.Detail.iMac_Yellow
        case "iPad_Blue": return ImageLiterals.Detail.iPad_Blue
        case "iPad_Pink": return ImageLiterals.Detail.iPad_Pink
        case "iPad_Silver": return ImageLiterals.Detail.iPad_Silver
        case "iPad_Yellow": return ImageLiterals.Detail.iPad_Yellow
        case "iPadAir_Blue": return ImageLiterals.Detail.iPadAir_Blue
        case "iPadAir_Purple": return ImageLiterals.Detail.iPadAir_Purple
        case "iPadAir_SpaceGray": return ImageLiterals.Detail.iPadAir_SpaceGray
        case "iPadAir_Starlight": return ImageLiterals.Detail.iPadAir_Starlight
        case "iPadMini_Blue": return ImageLiterals.Detail.iPadMini_Blue
        case "iPadMini_Purple": return ImageLiterals.Detail.iPadMini_Purple
        case "iPadMini_SpaceGray": return ImageLiterals.Detail.iPadMini_SpaceGray
        case "iPadMini_Starlight": return ImageLiterals.Detail.iPadMini_Starlight
        case "iPadPro_Silver": return ImageLiterals.Detail.iPadPro_Silver
        case "iPadPro_SpaceBlack": return ImageLiterals.Detail.iPadPro_SpaceBlack
        case "iPhone15_Black": return ImageLiterals.Detail.iPhone15_Black
        case "iPhone15_Blue": return ImageLiterals.Detail.iPhone15_Blue
        case "iPhone15_Green": return ImageLiterals.Detail.iPhone15_Green
        case "iPhone15_Pink": return ImageLiterals.Detail.iPhone15_Pink
        case "iPhone15_Yellow": return ImageLiterals.Detail.iPhone15_Yellow
        case "iPhone16_Black": return ImageLiterals.Detail.iPhone16_Black
        case "iPhone16_Pink": return ImageLiterals.Detail.iPhone16_Pink
        case "iPhone16_Teal": return ImageLiterals.Detail.iPhone16_Teal
        case "iPhone16_Ultramarine": return ImageLiterals.Detail.iPhone16_Ultramarine
        case "iPhone16_White": return ImageLiterals.Detail.iPhone16_White
        case "iPhone16e_Black": return ImageLiterals.Detail.iPhone16e_Black
        case "iPhone16e_White": return ImageLiterals.Detail.iPhone16e_White
        case "iPhone16Pro_BlackTitanium": return ImageLiterals.Detail.iPhone16Pro_BlackTitanium
        case "iPhone16Pro_DesertTitanium": return ImageLiterals.Detail.iPhone16Pro_DesertTitanium
        case "iPhone16Pro_NaturalTitanium": return ImageLiterals.Detail.iPhone16Pro_NaturalTitanium
        case "iPhone16Pro_WhiteTitanium": return ImageLiterals.Detail.iPhone16Pro_WhiteTitanium
        case "MacBookAir_Midnight": return ImageLiterals.Detail.macBookAir_Midnight
        case "MacBookAir_Silver": return ImageLiterals.Detail.macBookAir_Silver
        case "MacBookAir_SkyBlue": return ImageLiterals.Detail.macBookAir_SkyBlue
        case "MacBookAir_Starlight": return ImageLiterals.Detail.macBookAir_Starlight
        case "MacBookPro_Silver": return ImageLiterals.Detail.macBookPro_Silver
        case "MacBookPro_SpaceBlack": return ImageLiterals.Detail.macBookPro_SpaceBlack
        case "MacMini_Silver": return ImageLiterals.Detail.macMini_Silver
        case "MacPro_Silver": return ImageLiterals.Detail.macPro_Silver
        case "MacStudio_Silver": return ImageLiterals.Detail.macStudio_Silver
        case "MagicKeyboard_Black": return ImageLiterals.Detail.magicKeyboard_Black
        case "MagicKeyboard_White": return ImageLiterals.Detail.magicKeyboard_White
        case "MagicMouse_Black": return ImageLiterals.Detail.magicMouse_Black
        case "MagicMouse_White": return ImageLiterals.Detail.magicMouse_White
        case "MagicTrackpad_Black": return ImageLiterals.Detail.magicTrackpad_Black
        case "MagicTrackpad_White": return ImageLiterals.Detail.magicTrackpad_White
        case "MagSafeCase_Aquamarine": return ImageLiterals.Detail.magSafeCase_Aquamarine
        case "MagSafeCase_Peony": return ImageLiterals.Detail.magSafeCase_Peony
        case "MagSafeCase_Periwinkle": return ImageLiterals.Detail.magSafeCase_Periwinkle
        case "MagSafeCase_StarFruit": return ImageLiterals.Detail.magSafeCase_StarFruit
        case "MagSafeCase_Tangerine": return ImageLiterals.Detail.magSafeCase_Tangerine
        case "StudioDisplay_Silver": return ImageLiterals.Detail.studioDisplay_Silver
        case "StudioDisplayXDR_Silver": return ImageLiterals.Detail.studioDisplayXDR_Silver

        default: return nil
        }
    }
}

extension IEProduct {
    var primaryColor: IEColor {
        colors.first ?? .silver
    }
}
