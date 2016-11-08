//: Playground - noun: a place where people can play

import UIKit

struct APIKeys {
    static let imageURL = "https://cache.net-a-porter.com/images/"
}

struct Methods {
    static let product = "products/{pid}/{pid}_fr_sl.jpg"
}

struct URLKeys {
    static let pid = "pid"
}

let pid = "759984"

func subtituteKey(in method: String, key: String, value: String) -> String {
    let formattedMethod = method.replacingOccurrences(of: "{\(key)}", with: value)
    return formattedMethod
}

let methods = subtituteKey(in: Methods.product, key: URLKeys.pid, value: pid)
let urlString = APIKeys.imageURL + methods
print(methods)
print(urlString)

do {
    let id: NSNumber? = 232323
    //print(id)
    let ppp = id ?? 0
    print(ppp)
    if let ppid = id {
        let idString = String(describing: ppid)
        print(idString)
    }
}
