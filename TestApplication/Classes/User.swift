//
//  User.swift
//  TestApplication
//
//  Created by Андрей Илалов on 10.11.2017.
//  Copyright © 2017 Андрей Илалов. All rights reserved.
//

import Foundation
import SwiftyJSON

class User {
    let id: Int
    let firstName: String?
    let lastName: String?
    let email: String?
    let avatarUrl: String?
    let createdAt: String
    let updatedAt: String
    
//    init(id: Int, firstName: String?, lastName: String?, email: String?, avatarUrl: URL?, createdAt: String, updatedAt: String) {
//        self.id = id
//        self.firstName = firstName
//        self.lastName = lastName
//        self.email = email
//        self.avatarUrl = avatarUrl
//        self.createdAt = createdAt
//        self.updatedAt = updatedAt
//    }
    
     init(json: JSON) {
        self.id = json["id"].intValue
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.email = json["email"].stringValue
        self.avatarUrl = json["avatar_url"].stringValue
        self.createdAt = json["created_at"].stringValue
        self.updatedAt = json["updated_at"].stringValue
    }
    
    init() {
       self.email = ""
        self.avatarUrl = ""
        self.createdAt = ""
        self.firstName = ""
        self.lastName = ""
        self.updatedAt = ""
        self.id = 0
    }

}

//{
//"id":1,
//"first_name":"Foo",
//"last_name":"Bar",
//"email":"foo@bar.com",
//"avatar_url":"",
//"created_at":"2016-09-20T14:44:33.573Z",
//"updated_at":"2016-09-20T14:44:33.573Z"
