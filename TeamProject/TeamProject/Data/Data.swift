//
//  Data.swift
//  TeamProject
//
//  Created by 천성우 on 4/7/25.
//

import Foundation

let products: [IEProduct] = [
    IEProduct(
        id: 0,
        name: "MacBook Air 13 및 15",
        imageName: "MacBookAir",
        price: 1590000,
        description: "어디서든 일하고, 즐기고, 창작할 수 있도록 해주는 놀랍도록 얇고 빠른 노트북.",
        colors: [.midnight, .silver, .skyBlue, .starlight],
        category: .mac
    ),
    IEProduct(
        id: 1,
        name: "MacBook Pro 14 및 16",
        imageName: "MacBookPro",
        price: 2390000,
        description: "막대한 워크플로도 너끈히 처리하는 가장 앞선 Mac 노트북.",
        colors: [.silver, .spaceBlack],
        category: .mac
    ),
    IEProduct(
        id: 2,
        name: "iMac",
        imageName: "iMac",
        price: 1990000,
        description: "창의적인 작업도 생산적 업무도 척척. 놀라운 올인원 데스크탑.",
        colors: [.blue, .green, .orange, .pink, .purple, .silver, .yellow],
        category: .mac
    ),
    IEProduct(
        id: 3,
        name: "Mac mini",
        imageName: "MacMini",
        price: 890000,
        description: "막강한 성능을 선사하는 가장 작고 부담 없는 Mac.",
        colors: [.silver],
        category: .mac
    ),
    IEProduct(
        id: 4,
        name: "Mac Studio",
        imageName: "MacStudio",
        price: 3290000,
        description: "전문 워크플로를 위한 강력한 성능 및 빈틈없는 연결성.",
        colors: [.silver],
        category: .mac
    ),
    IEProduct(
        id: 5,
        name: "MacPro",
        imageName: "MacPro",
        price: 10490000,
        description: "PCIe 확장으로 막대한 워크플로도 너끈히 처리할 수 있는 전문가용 워크스테이션.",
        colors: [.silver],
        category: .mac
    ),
    IEProduct(
        id: 6,
        name: "Studio Display",
        imageName: "StudioDisplay",
        price: 2090000,
        description: "뛰어난 카메라와 오디오를 갖춘 5K Retina 디스플레이",
        colors: [.silver],
        category: .mac
    ),
    IEProduct(
        id: 7,
        name: "Pro Display XDR",
        imageName: "ProDisplayXDR",
        price: 6499000,
        description: "프로 워크플로에 적합한 첨단 6K XDR 디스플레이.",
        colors: [.silver],
        category: .mac
    ),
    IEProduct(
        id: 8,
        name: "iPad Pro",
        imageName: "iPadPro",
        price: 1599000,
        description: "최첨단 기술이 구현하는 궁극의 iPad 경험.",
        colors: [.silver, .spaceBlack],
        category: .iPad
    ),
    IEProduct(
        id: 9,
        name: "iPad Air",
        imageName: "iPadAir",
        price: 949000,
        description: "얇고 가벼운 디자인. 결코 가볍지 않은 성능.",
        colors: [.blue, .purple, .spaceGray, .starlight],
        category: .iPad
    ),
    IEProduct(
        id: 10,
        name: "iPad",
        imageName: "iPad",
        price: 529000,
        description: "매일매일 여러 일을 척척. 널찍한 화면. 화사한 색상.",
        colors: [.blue, .pink, .silver, .yellow],
        category: .iPad
    ),
    IEProduct(
        id: 11,
        name: "iPad mini",
        imageName: "iPadMini",
        price: 749000,
        description: "iPad다운 경험은 그대로. 휴대성은 최대로.",
        colors: [.blue, .purple, .spaceGray, .starlight],
        category: .iPad
    ),
    IEProduct(
        id: 12,
        name: "iPhone 16 Pro",
        imageName: "iPhone16Pro",
        price: 1550000,
        description: "궁극의 iPhone.",
        colors: [.blackTitanium, .desertTitanium, .naturalTitanium, .whiteTitanium],
        category: .iPhone
    ),
    IEProduct(
        id: 13,
        name: "iPhone 16",
        imageName: "iPhone16",
        price: 1250000,
        description: "막강한 성능.",
        colors: [.black, .pink, .teal, .ultramarine, .white],
        category: .iPhone
    ),
    IEProduct(
        id: 14,
        name: "iPhone 16e",
        imageName: "iPhone16e",
        price: 990000,
        description: "새로운 iPhone. 놀라운 실속.",
        colors: [.black, .white],
        category: .iPhone
    ),
    IEProduct(
        id: 15,
        name: "iPhone 15",
        imageName: "iPhone15",
        price: 1090000,
        description: "여전한 놀라움.",
        colors: [.black, .blue, .green, .pink, .yellow],
        category: .iPhone
    ),
    IEProduct(
        id: 16,
        name: "iPhone 16 Pro 실리콘 케이스",
        imageName: "MagSafeCase",
        price: 69000,
        description: "",
        colors: [.aquamarine, .peony, .periwinkle, .starFruit, .tangerine],
        category: .acc
    ),
    IEProduct(
        id: 17,
        name: "AirPods Pro 2",
        imageName: "AirPodsPro2",
        price: 349000,
        description: "",
        colors: [.white],
        category: .acc
    ),
    IEProduct(
        id: 18,
        name: "AirPods Max",
        imageName: "AirPodsMax",
        price: 769000,
        description: "",
        colors: [.blue, .midnight, .orange, .purple, .starlight],
        category: .acc
    ),
    IEProduct(
        id: 19,
        name: "Apple Pencil Pro",
        imageName: "ApplePencilPro",
        price: 195000,
        description: "",
        colors: [.white],
        category: .acc
    ),
    IEProduct(
        id: 20,
        name: "Magic Trackpad",
        imageName: "MagicTrackpad",
        price: 169000,
        description: "",
        colors: [.black, .white],
        category: .acc
    ),
    IEProduct(
        id: 21,
        name: "Magic Mouse",
        imageName: "MagicMouse",
        price: 139000,
        description: "",
        colors: [.black, .white],
        category: .acc
    ),
    IEProduct(
        id: 22,
        name: "Magic Keyboard",
        imageName: "MagicKeyboard",
        price: 279000,
        description: "",
        colors: [.black, .white],
        category: .acc
    )
]
