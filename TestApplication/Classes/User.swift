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

