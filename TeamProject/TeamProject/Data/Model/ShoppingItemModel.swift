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
    
    init?(cartModel: IECartModel, products: [IEProduct]) {
        guard let product = products.first(where: { $0.id == cartModel.productID }) else {
            return nil
        }

        self.id = cartModel.id
        self.image = ImageLiterals.Detail.image(for: product, color: cartModel.selectedColor)
        self.title = product.name
        self.description = product.description
        self.price = product.price
        self.quantity = cartModel.cartQuantity
        self.color = cartModel.selectedColor
    }
}

