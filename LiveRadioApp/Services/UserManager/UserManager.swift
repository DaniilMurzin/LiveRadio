//
//  UserManager.swift
//  RadioApp
//
//  Created by Daniil Murzin on 01.09.2025.
//

import Foundation
import FirebaseFirestore

protocol UserRepository {
    func createNewUser(_ user: DBUser) async throws
    func getUser(_ id: DBUser.ID ) async throws -> DBUser
    func updateUser(_ user: DBUser) async throws
    func updateUsersName(_ newName: String, id: DBUser.ID) async throws
    func newUserResult(user: User) async -> Result<User, Error>
    func currentUserResult(_ id: DBUser.ID) async throws -> Result<User, Error>
}

final class UserManager: UserRepository {
    
    private let userCollection = Firestore.firestore().collection("users")
    
    init() {}
    
    private func userDocument(_ id: DBUser.ID) -> DocumentReference {
        userCollection.document(id.rawValue)
    }
    
    func createNewUser(_ user: DBUser) async throws {
        try userDocument(user.userId).setData(from: user, merge: false)
    }
    
    func newUserResult(user: User) async -> Result<User, Error> {
        await Result {
            let dbUser = DBUser(user)
            try await createNewUser(dbUser)
            return user
        }
    }
    
    func getUser(_ id: DBUser.ID) async throws -> DBUser {
        try await userDocument(id).getDocument(as: DBUser.self)
    }
    
    func currentUserResult(_ id: DBUser.ID) async throws -> Result<User, Error> {
        await Result<DBUser.ID,Error>
            .success(id)
            .asyncTryMap(getUser(_:))
            .map(User.init)
    }
    
    func updateUser(_ user: DBUser) async throws {
        try userDocument(user.userId).setData(from: user, merge: true)
    }
    
    func updateUsersName(_ newName: String, id: DBUser.ID) async throws {
        
        let data: [String:Any] = [DBUser.CodingKeys.name.rawValue : newName]
        try await userDocument(id).updateData(data)
    }
}
