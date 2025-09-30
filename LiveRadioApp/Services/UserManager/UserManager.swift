//
//  UserManager.swift
//  RadioApp
//
//  Created by Daniil Murzin on 01.09.2025.
//


#warning("ревью")
import Foundation
import FirebaseFirestore

protocol UserRepository {
    func createNewUser(_ user: DBUser) async throws
    func getUser(userId: String ) async throws -> DBUser
    func updateUser(_ user: DBUser) async throws
    func updateUsersName(_ newName: String, userId: String) async throws
}

struct DBUser: Codable  {
    
    let userId: String
    let dateCreated: Date?
    let name: String?
    let email: String?
    let photoURL: String?
    
    init(_ user: User) {
        self.userId = user.id
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
        self.userId = userId
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
        self.userId = try container.decode(String.self, forKey: .userId)
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
//            userId: userId,
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

final class UserManager: UserRepository {
    
    private let userCollection = Firestore.firestore().collection("users")
    
//    private let encoder: Firestore.Encoder = {
//        let encoder = Firestore.Encoder()
//        encoder.keyEncodingStrategy = .convertToSnakeCase
//        return encoder
//    }()
//    
//    private let decoder: Firestore.Decoder = {
//        let decoder = Firestore.Decoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
//        return decoder
//    }()
    
    init() {}
    
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    func createNewUser(_ user: DBUser) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: false)
    }
    
    func getUser(userId: String ) async throws -> DBUser {
        try await userDocument(userId: userId).getDocument(as: DBUser.self)
    }
    
    func updateUser(_ user: DBUser) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: true)
    }
    
    func updateUsersName(_ newName: String, userId: String) async throws {
        
        let data: [String:Any] = [DBUser.CodingKeys.name.rawValue : newName]
        try await userDocument(userId: userId).updateData(data)
    }
    
    
//    func createNewUser(_ user: User) async throws {
//       
//        var userData: [String: Any] = [
//            "user_id": user.id,
//            "date_created" : Timestamp()
//        ]
//        
//        if let email = user.email {
//            userData["email"] = email
//        }
//        
//        if let name = user.name {
//            userData["name"] = name
//        }
//        
//        if let photoURL = user.photoURL {
//            userData["photo_url"] = photoURL
//        }
//        
//        try await userDocument(userId: user.id).setData(userData, merge: false)
//    }
    
//    func getUser(userId: String ) async throws -> DBUser {
//        let snapshot = try await userCollection
//            .document(userId)
//            .getDocument()
//        
//        guard let data = snapshot.data(),
//              let userId = data["user_id"] as? String
//           else { throw AuthServiceError.badDataResponse }
//        
//       
//        let date = data["date_created"] as? Date
//        let name = data["name"] as? String
//        let email = data["email"] as? String
//        let photoURL = data["photo_url"] as? String
//        
//        return DBUser(
//            userId: userId,
//            dateCreated: date,
//            name: name,
//            email: email,
//            photoURL: photoURL
//        )
//        
//    }
}
