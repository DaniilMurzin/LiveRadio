//
//  DBUser.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 05.10.2025.
//

//
//  DBUser.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 05.10.2025.
//

import Foundation

struct DBUser: Codable  {
    
    typealias ID = Identifier<DBUser, String>
    
    let userId: ID
    let dateCreated: Date?
    let name: String?
    let email: String?
    let photoURL: String?
    
    init(_ user: LocalUser) {
        self.userId = ID(rawValue: user.id.rawValue)
        self.email = user.email
        self.name = user.name
        self.dateCreated = Date()
        self.photoURL = user.photoURL
    }
    
    init(
        userId: String,
        dateCreated: Date? = nil,
        name: String? = nil,
        email: String? = nil,
        photoURL: String? = nil
    ) {
        self.userId = ID(rawValue: userId)
        self.dateCreated = dateCreated
        self.name = name
        self.email = email
        self.photoURL = photoURL
    }
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case dateCreated = "date_created"
        case name = "name"
        case email = "email"
        case photoURL = "photo_url"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(ID.self, forKey: .userId)
        self.dateCreated = try container.decodeIfPresent(Date.self, forKey: .dateCreated)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.photoURL = try container.decodeIfPresent(String.self, forKey: .photoURL)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(userId, forKey: .userId)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(email, forKey: .email)
    }
    
//    func changeUserName(_ newName: String) -> DBUser {
//        return DBUser(
//            dbUserId: dbUserId,
//            dateCreated: dateCreated,
//            name: newName,
//            email: email,
//            photoURL: photoURL
//        )
//    }
//    mutating func changeUserName(_ newName: String) {
//        name = newName
//    }
}
