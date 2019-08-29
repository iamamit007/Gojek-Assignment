//
//  ContactListModel.swift
//  Gojek-Assignment
//
//  Created by Amit on 28/08/19.
//  Copyright © 2019 Amit. All rights reserved.
//

import Foundation

//{
//    "id": 9894,
//    "first_name": "Amitabh123",
//    "last_name": "Bachchan",
//    "profile_pic": "/images/missing.png",
//    "favorite": true,
//    "url": "http://gojek-contacts-app.herokuapp.com/contacts/9894.json"
//}


struct contactListResult:Decodable {
    var id :Int?
    var first_name:String?
    var last_name:String?
    var profile_pic:String?
    var favorite :Bool?
    var url:String?
}
struct ContactItems:Decodable {
    var id :Int?
    var first_name:String?
    var last_name:String?
    var profile_pic:String?
    var favorite :Bool?
    var url:String?
}
