//
//  ApiPoint.swift
//  SchoolLink
//
//  Created by Abhishek Pachal on 2/11/19.
//  Copyright © 2019 Abhishek Pachal. All rights reserved.
//

import Foundation

protocol Apipoint {
    
    var base: String { get }
    var path: String { get }
}


extension Apipoint {
    
    var urlComponents: URLComponents {
        print(base)
        var components = URLComponents(string: base)!
        print(components.host)
      //  components.path = path
        return components
    }
    
    var posturlComponents: URLComponents {
        let base_url = base
        let path_url = path
        
        print("@ayan----->",base_url,path_url)
        var components = URLComponents(string: "\(base_url)\(path_url)" )!
       // components.path = path_url
        
        return components
    }
    
    var getrequest: URLRequest {
        let url = urlComponents.url!
        var req = URLRequest(url: url)
        req.httpMethod = "GET"
        
        
        return req
    }
    
    var postrequest: URLRequest {
        
        let url = posturlComponents.url!
        print("@eeeee--->",url.absoluteString)
        var req = URLRequest(url: url)
        req.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        req.httpMethod = "POST"
        
        return req
    }
}

enum GenericFeed {
    // what type of api
    case contacts
}

extension GenericFeed: Apipoint {
    
    var base: String {
        return  Constants.BASE_URL
    }
    
    var path: String {
        
        switch self {
        case .contacts: return base + urlEncodeString("/contacts.json")
       
        }
    }
    
    
    func urlEncodeString(_ endpoinr:String) ->String{
        return endpoinr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
    }
}
