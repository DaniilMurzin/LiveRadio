//
//  Models.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 26.09.2024.
//

import Foundation

struct Email: Equatable {
    let wrapped: String
    
    private init(wrapped: String) {
        self.wrapped = wrapped
    }
    
    init?(_ email: String) {
        guard email.contains("@") && email.count > 7 else {
            return nil
        }
        self.wrapped = email
    }
    
    static func parce(_ email: String) -> Result<Email, Error> {
        
        Result {
            guard email.contains("@") else {
                throw EmailError.nonEmail
            }
            
            guard email.count > 7 else {
                throw EmailError.tooShort
            }
            
            return Email(wrapped: email)
        }
    }
}

struct Password: Equatable {
    let wrapped: String
    
    private init (wrapped: String) {
        self.wrapped = wrapped
    }
    
    init?(_ password: String) {
        guard password.count > 8 else {
            return nil
        }
        self.wrapped = password
    }
    
    static func parce(_ password: String) -> Result<Password, Error> {
        Result {
            guard password.count > 8 else {
                throw NSError(domain: "Auth", code: 404)
            }
            return Password(wrapped: password)
        }
    }
}

struct Credentials: Equatable {
    let email: Email
    let password: Password
    
    private init (email: Email, password: Password) {
        self.email = email
        self.password = password
    }
    
    init?(email: String, password: String) {
        guard let email = Email(email),
              let password = Password(password)
        else { return nil }
        
        self.email = email
        self.password = password
    }
    
    static func parce(
        email: String,
        password: String
    ) -> Result<Credentials, Error> {
        Result.zip(
            Email.parce(email),
            Password.parce(password)
        )
        .map(Credentials.init)
    }
}

    struct User: Equatable {
        
        let id: String
        let email: String?
        let name: String?
        let photoURL: String?
        
        var userId: DBUser.ID  { DBUser.ID(rawValue: id	)}
        
        init(
            id: String,
            email: String?,
            name: String?,
            photoURL: String?
        ) {
            self.id = id
            self.email = email
            self.name = name
            self.photoURL = photoURL
        }
        
        init(db: DBUser) {
            self.init(
                id: db.userId.rawValue,
                email: db.email,
                name: db.name,
                photoURL: db.photoURL
            )
        }
    }
    
    enum EmailError: Error {
        case tooShort
        case nonEmail
    }
