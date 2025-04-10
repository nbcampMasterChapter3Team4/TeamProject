//
//  ShoppingItemModel.swift
//  TeamProject
//
//  Created by yimkeul on 4/10/25.
//

import UIKit

struct ShoppingItemModel {
    let id: UUID // IECartModel ID
    let image: UIImage // IEProduct image
    let title: String // IEProduct image
    let description: String // IEProduct image
    let price: Int // IECartModel price
    var quantity: Int // IECartModel cartQuantity
    let color: IEColor // IECartModel selectedColor
}
