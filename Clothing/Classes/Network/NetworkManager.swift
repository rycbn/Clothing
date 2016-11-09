//
//  NetworkManager.swift
//  Clothing
//
//  Created by Roger Yong on 17/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation

protocol NetworkURLSession {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

enum NetworkError: Error {
    case url, data, json, error, response
}

enum NetworkResponse {
    case onSuccess(AnyObject)
    case onEror(NetworkError)
}

class NetworkManager {

    typealias CompletionHandler = (NetworkResponse) -> Void

    lazy var session: NetworkURLSession = URLSession.shared

    func taskForGET(with method: String, parameters: [String: String], completionHandler: @escaping CompletionHandler) -> URLSessionDataTask {

        var mutableParameters = parameters
        mutableParameters[ParameterKeys.categoryIds] = ParameterValues.categoryIds

        let urlString = APIKeys.baseURL + method +  NetworkManager.escapedParameters(parameters: mutableParameters)

        guard let url = URL(string: urlString) else {
            let error = NetworkResponse.onEror(.url)
            completionHandler(error)
            return URLSessionDataTask()
        }

        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30)
        request.httpMethod = HTTPMethods.get

        let task = self.session.dataTask(with: request) { (data, response, error) in

            guard error == nil else {
                let error = NetworkResponse.onEror(.error)
                return completionHandler(error)
            }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                let error = NetworkResponse.onEror(.response)
                return completionHandler(error)
            }
            guard let data = data else {
                let error = NetworkResponse.onEror(.data)
                return completionHandler(error)
            }
            NetworkManager.parseringJSON(data, completionHandler: completionHandler)
        }

        task.resume()

        return task
    }

    class func parseringJSON(_ data: Data, completionHandler: CompletionHandler) {
        do {
            let parsedObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
            let success = NetworkResponse.onSuccess(parsedObject)
            completionHandler(success)
        } catch {
            let error = NetworkResponse.onEror(.json)
            completionHandler(error)
        }
    }

    class func escapedParameters(parameters: [String : String]) -> String {
        var urlVars = [String]()
        for (key, value) in parameters {
            let stringValue = "\(value)"
            let escapedValue = stringValue.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            urlVars += [key + "=" + "\(escapedValue!)"]
        }
        return (!urlVars.isEmpty ? "?" : "") + urlVars.joined(separator: "&")
    }
}

extension URLSession: NetworkURLSession {}




