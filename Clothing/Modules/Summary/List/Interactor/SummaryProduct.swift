//
//  SummaryProduct.swift
//  Clothing
//
//  Created by Roger Yong on 18/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit

class SummaryProduct {
    
    var id: NSNumber!
    var name: String!
    var favouriteSelected: Bool!
    var currencyAmount: String!
    var imageURL: String!
    var indicator: UIActivityIndicatorView!
    var image: UIImage!
    var task: URLSessionTask!

    func heightForName(_ font: UIFont, width: CGFloat) -> CGFloat {
        let size = CGSize(width: width, height: CGFloat(MAXFLOAT))
        let rect = NSString(string: name).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return ceil(rect.height)
    }
    
}
