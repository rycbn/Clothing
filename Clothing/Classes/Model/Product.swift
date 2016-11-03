//
//  Product.swift
//  Clothing
//
//  Created by Roger Yong on 18/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation

struct Product {
    let id: NSNumber
    let name: String
    let favouriteSelected: Bool
    let currency: String
    let divisor: NSNumber
    let amount: NSNumber
    let imageURL: String

    init(id: NSNumber, name: String, favouriteSelected: Bool = false, currency: String, divisor: NSNumber, amount: NSNumber, imageURL: String) {
        self.id = id
        self.name = name
        self.favouriteSelected = favouriteSelected
        self.currency = currency
        self.divisor = divisor
        self.amount = amount
        self.imageURL = imageURL
    }
}
