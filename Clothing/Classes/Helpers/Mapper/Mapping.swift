//
//  Mapping.swift
//  Clothing
//
//  Created by Roger Yong on 18/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation

protocol Mapping {
    associatedtype Input
    associatedtype Output

    static func mapElement(_ element: Input) -> Output
}
