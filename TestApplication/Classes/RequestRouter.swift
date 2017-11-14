//
//  RequestRouter.swift
//  TestApplication
//
//  Created by Андрей Илалов on 10.11.2017.
//  Copyright © 2017 Андрей Илалов. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import AlamofireImage


class RequestRouter {

    func dowloadUserInfo(completion: @escaping ([User]) -> Void) {
        
        let url = "https://bb-test-server.herokuapp.com/users.json"
        
        Alamofire.request(url).responseJSON { response in
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                let json1 = JSON(json)
                var users: [User] = []
                for i in json1 {
                    users.append(User(json: i.1))
                }
                completion(users)
            }
        }
    }
    
    func editUserInfo(firstName: String?, lastName: String?, email: String?, avatarUrl: String?, id: Int) {
        let parameters: Parameters = [
            "user": [
                "first_name":firstName ?? "",
                "last_name":lastName ?? "",
                "email":email ?? "",
                "avatar_url":avatarUrl ?? ""
            ]
        ]
        
        let url = "https://bb-test-server.herokuapp.com/users/" + String(id) + ".json"
        
        Alamofire.request(url, method: .patch, parameters: parameters).responseJSON { response in
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
        }
        
    }
    
    
    func addUser(firstName: String?, lastName: String?, email: String?, avatarUrl: String?){
        let parameters: Parameters = [
            "user": [
                "first_name":firstName ?? "",
                "last_name":lastName ?? "",
                "email":email ?? "",
                "avatar_url":avatarUrl ?? ""
            ]
        ]
        
        let url = "https://bb-test-server.herokuapp.com/users.json"
        
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { response in
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
        }
    }
    
}
