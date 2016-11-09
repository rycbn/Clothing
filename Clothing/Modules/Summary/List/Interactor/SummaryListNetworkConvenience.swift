//
//  SummaryNetworkConvenience.swift
//  Clothing
//
//  Created by Roger Yong on 18/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation

extension NetworkManager {

    func loadingSummaryListFromAPI(_ completionHandler: @escaping CompletionHandler) {
        let parameters = [String: String]()
        let method = Methods.summary
        let _ = self.taskForGET(with: method, parameters: parameters) { (results) in
            completionHandler(results)
        }
    }
    
}
