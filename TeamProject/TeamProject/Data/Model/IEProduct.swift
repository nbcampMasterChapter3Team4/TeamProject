//
//  IEProduct.swift
//  TeamProject
//
//  Created by 서동환 on 4/8/25.
//

import Foundation

struct IEProduct: Hashable {
    let id: UUID
    let name: String
    var imageName: String
    var price: Int
    var description: String
    var colors: [IEColor]
    var category: IECategory
}
