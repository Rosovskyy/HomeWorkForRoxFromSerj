//
//  UserAPIClient.swift
//  UCU_iOS_app_Architectures
//
//  Created by Roxane Gud on 4/27/20.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import Foundation

final class ChatAPIClient: Delayable { }

final class VideoAPIClient: Delayable {
    func load(_ url: URL) {}
}

final class UserAPIClient: Delayable {

    func getMe(completion: @escaping ((User) -> Void)) {
        delay { // rox: simulate networking delay
            let user = User(userId: "0")
            
            user.firstName = "Buffy"
            user.lastName = "Summers"
            user.city = "Los Angeles"
            user.country = "USA"
            user.avatarURL = "C1"

            completion(user)
        }
    }
    
    func getFriends(completion: @escaping ([User]) -> Void) {
        delay { // rox: simulate networking delay
            var result = [User]()
            
            if let usersArray = Bundle.main.loadJSON("Users") as? Array<[String: Any]> {
                for userDictionary in usersArray {
                    
                    if let user = User(json: userDictionary) {
                        result.append(user)
                    }
                }
            }
            
            completion(result)
        }
    }
    
    func getUser(userId: String, completion: @escaping (User?) -> Void) {
        delay { // rox: simulate networking delay

            if let usersArray = Bundle.main.loadJSON("Users") as? Array<[String: Any]> {
                for userDictionary in usersArray {
                    
                    if let user = User(json: userDictionary), user.userId == userId {
                        completion(user)
                        return
                    }
                }
            }
            
            completion(nil)
        }
    }
}

fileprivate extension Bundle {
    func loadJSON(_ filename: String) -> Any {
        guard let path = path(forResource: filename, ofType: "json") else {
            return []
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            if let jsonResult = jsonResult as? Array<AnyObject> {
                
                return jsonResult
            }
        } catch {
            
            return []
        }
        
        return []
    }
}

fileprivate extension User {
    convenience init?(json: [String: Any]) {
        guard let userId = json["userID"] as? String else { return nil }
        
        self.init(userId: userId)
        
        firstName = json["firstName"] as? String
        lastName = json["lastName"] as? String
        
        city = json["city"] as? String
        country = json["country"] as? String
        
        avatarURL = json["imageURL"] as? String
    }
}
