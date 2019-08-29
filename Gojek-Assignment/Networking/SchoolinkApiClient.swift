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
    
    func getAllContacts(from feedType:GenericFeed,completion: @escaping (Result<[contactListResult], APIError>) -> Void) {

        let endpoint = feedType
      //  let path = endpoint.path.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
     //   let components = URLComponents(string: endpoint.path)!
        print("\(endpoint.path)")
        let url = URL(string: "http://gojek-contacts-app.herokuapp.com/contacts.json")
       
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"


        fetch(with: request, decode: { json -> [contactListResult]? in
            guard let contactListResult = json as? [contactListResult] else { return  nil }
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


extension CharacterSet {
    
    /// Characters valid in at least one part of a URL.
    ///
    /// These characters are not allowed in ALL parts of a URL; each part has different requirements. This set is useful for checking for Unicode characters that need to be percent encoded before performing a validity check on individual URL components.
    static var urlAllowedCharacters: CharacterSet {
        // Start by including hash, which isn't in any set
        var characters = CharacterSet(charactersIn: "#")
        // All URL-legal characters
        characters.formUnion(.urlUserAllowed)
        characters.formUnion(.urlPasswordAllowed)
        characters.formUnion(.urlHostAllowed)
        characters.formUnion(.urlPathAllowed)
        characters.formUnion(.urlQueryAllowed)
        characters.formUnion(.urlFragmentAllowed)
        
        return characters
    }
}

extension String {
    
    /// Converts a string to a percent-encoded URL, including Unicode characters.
    ///
    /// - Returns: An encoded URL if all steps succeed, otherwise nil.
    func encodedUrl() -> URL? {
        // Remove preexisting encoding,
        guard let decodedString = self.removingPercentEncoding,
            // encode any Unicode characters so URLComponents doesn't choke,
            let unicodeEncodedString = decodedString.addingPercentEncoding(withAllowedCharacters: .urlAllowedCharacters),
            // break into components to use proper encoding for each part,
            let components = URLComponents(string: unicodeEncodedString),
            // and reencode, to revert decoding while encoding missed characters.
            let percentEncodedUrl = components.url else {
                // Encoding failed
                return nil
        }
        
        return percentEncodedUrl
    }
    
}
