//
//  SchoolinkApiClient.swift
//  SchoolLink
//
//  Created by Abhishek Pachal on 2/11/19.
//  Copyright © 2019 Abhishek Pachal. All rights reserved.
//

import Foundation

class SchoolinkApiClient: APIClient {
let session: URLSession

init(configuration: URLSessionConfiguration) {
    self.session = URLSession(configuration: configuration)
}

convenience init() {
    self.init(configuration: .default)
}
    
    func getAllContacts(from feedType:GenericFeed,completion: @escaping (Result<contactListResult, APIError>) -> Void) {

        let endpoint = feedType
        let path = endpoint.path
        let components = URLComponents(string: endpoint.base)!
        let url = components.url!
        print("oooooo--->",url.absoluteString)
        print("oooooo--->",url.absoluteURL)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"


        fetch(with: request, decode: { json -> contactListResult? in
            guard let contactListResult = json as? contactListResult else { return  nil }
            return contactListResult
        }, completion: completion)
    }
    
    
    
    
    
    
    
    
//    func fetchBusPosition(from feedType:GenericFeed,params:bus_position_params, completion: @escaping (Result<bus_position_result, APIError>) -> Void) {
//
//        let endpoint = feedType
//        var request = endpoint.postrequest
//        let ob = try? JSONEncoder().encode(params)
//        let jsonStr = String(data: ob!, encoding: .utf8)
//        request.httpBody = jsonStr?.data(using: .utf8)
//
//        fetch(with: request, decode: { json -> bus_position_result? in
//            let result = json as? bus_position_result
//            return result
//        }, completion: completion)
//    }
    
}


