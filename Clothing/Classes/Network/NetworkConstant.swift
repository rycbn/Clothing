//
//  NetworkConstant.swift
//  Clothing
//
//  Created by Roger Yong on 17/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation

struct APIKeys {
    static let baseURL = "https://api.net-a-porter.com/"
    static let imageURL = "https://cache.net-a-porter.com/images/products/{pid}/{pid}_fr_sl.jpg"
}

struct Methods {
    static let summary = "NAP/GB/en/60/0/summaries"
}

struct ParameterKeys {
    static let categoryIds = "categoryIds"
}

struct ParameterValues {
    static let categoryIds = "2"
}

struct URLKeys {
    static let pid = "pid"
}

struct HTTPMethods {
    static let get = "GET"
}

struct JSONResponseKeys {
    static let summaries = "summaries"
    static let name = "name"
    static let id = "id"
    static let price = "price"
}

struct JSONResponseKeyPaths {
    static let currency = "price.currency"
    static let divisor = "price.divisor"
    static let amount = "price.amount"
}

