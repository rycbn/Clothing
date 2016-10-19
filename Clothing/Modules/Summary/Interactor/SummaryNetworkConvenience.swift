//
//  SummaryNetworkConvenience.swift
//  Clothing
//
//  Created by Roger Yong on 18/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation

extension NetworkManager {

    func loadingSummaryFromAPI(_ completionHandler: @escaping CompletionHandler) {
        let parameters = [String: String]()
        let method = Methods.summary
        _ = self.taskForGET(with: method, parameters: parameters, completionHandler: { (resutls, error) in
            DispatchQueue.main.async {
                guard error == nil else {
                    return completionHandler(nil, error)
                }
                guard let resutls = resutls else {
                    return completionHandler(nil, error)
                }
                completionHandler(resutls, nil)
            }
        })
    }
}
