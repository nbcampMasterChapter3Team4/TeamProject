//
//  IECartModel.swift
//  TeamProject
//
//  Created by 서동환 on 4/9/25.
//

import Foundation

struct IECartModel {
    /// CoreData에 저장되어있는 UUID
    let id: UUID
    /// IEProduct의 UUID
    let productID: UUID
    var selectedColor: IEColor
    var cartQuantity: Int
}
