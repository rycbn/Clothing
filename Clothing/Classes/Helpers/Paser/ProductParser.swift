//
//  ProductParser.swift
//  Clothing
//
//  Created by Roger Yong on 18/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation

struct ProductParser: Mapping {

    static func mapElement(_ element: ManagedProduct) -> Product {
        guard
            let id = element.id,
            let name = element.name,
            let currency = element.price?.currency,
            let divisor = element.price?.divisor,
            let amount = element.price?.amount,
            let imageURL = element.imageURL
        else {
            fatalError("Error when parsing elements")
        }
        return Product(id: id, name: name, favouriteSelected: element.favouriteSelected, currency: currency, divisor: divisor, amount: amount, imageURL: imageURL)
    }
}
