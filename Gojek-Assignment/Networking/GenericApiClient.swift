//
//  GenericApiClient.swift
//  SchoolLink
//
//  Created by Abhishek Pachal on 2/11/19.
//  Copyright © 2019 Abhishek Pachal. All rights reserved.
//

import Foundation
//import KRProgressHUD
enum APIError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        }
    }
}

protocol APIClient {
    
    var session: URLSession { get }
    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void)
    
}

extension APIClient {
    
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    
    func decodingTask<T: Decodable>(with request: URLRequest, decodingType: T.Type, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        
        
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            
            print(httpResponse.statusCode)
            print("@ayan-->decodingType",decodingType)
            //for test
            
            
            
            if httpResponse.statusCode == 200 {
                
                
                do {
                    let stringDic = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any]
                    print(stringDic)
                } catch let error {
                    print(error)
                }
                if let data = data {
                    do {
                        //print("ascb",data.base64EncodedString())
                        let genericModel = try JSONDecoder().decode(decodingType, from: data)
                        print("@ayan-->",decodingType,data)
                        completion(genericModel, nil)
                    } catch {
                        completion(nil, .jsonConversionFailure)
                    }
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .responseUnsuccessful)
            }
        }
        return task
    }
    
    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void) {
        
        let task = decodingTask(with: request, decodingType: T.self) { (json , error) in
            //MARK: change to main queue
            
            print(json)
            DispatchQueue.main.async {
                print("@ayan------->raw json",json)
                guard let json = json else {
                    
                    
                    if let error = error {
                        
//                        KRProgressHUD.showMessage("Something went wrong.Please try Again")
//                        let delayInSeconds = 4.0
//                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
//                           KRProgressHUD.dismiss() // here code perfomed with delay
//
//                        }
                        
                        completion(Result.failure(error))
                    } else {
                        completion(Result.failure(.invalidData))
                    }
                    return
                }
                if let value = decode(json) {
                    completion(.success(value))
                } else {
                    //KRProgressHUD.showMessage("Something went wrong.Please try Again")
//                    let delayInSeconds = 4.0
//                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
//                        KRProgressHUD.dismiss() // here code perfomed with delay
//
//                    }
                    
                    completion(.failure(.jsonParsingFailure))
                }
            }
        }
        task.resume()
    }
}
