//
//  Model.swift
//  Stargazers
//
//  Created by zsolt on 28/03/2021.
//

import Foundation

struct User: Codable {
    let name: String
    let avatar: String
    
    private enum CodingKeys : String, CodingKey {
        case name = "login"
        case avatar = "avatar_url"
    }
    
    init(name: String, avatar: String) {
        self.name = name
        self.avatar = avatar
    }
}

struct Wrapper<ModelType: Decodable>: Decodable {
    let items: [ModelType]
    
    enum CodingKeys: String, CodingKey {
        case items
    }
}
