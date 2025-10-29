//
//  Models.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 26.09.2024.
//

import Foundation

struct UserName: Equatable {
    let wrapped: String
    
    init?(_ name: String) {
        guard name.trimmingCharacters(in: .whitespacesAndNewlines).count > 3 else { return nil }
        self.wrapped = name
    }
    
    init(from name: String) throws {
        guard name.trimmingCharacters(in: .whitespacesAndNewlines).count > 3 else { throw AuthError.tooShort }
        self.wrapped = name
    }
    
    private init(wrapped: String) { self.wrapped = wrapped}
    
    static func parse(_ name: String) -> Result<UserName, Error> {
        
        Result {
            guard name.count > 3 else { throw AuthError.tooShort }
            
            return UserName(wrapped: name)
        }
    }
}

struct Email: Equatable {
    let wrapped: String
    
    private init(wrapped: String) {
        self.wrapped = wrapped
    }
    
    init?(_ email: String) {
        guard email.contains("@") else { return nil }
        guard email.count > 7 else { return nil }
        self.wrapped = email
    }
    
    init(from email: String) throws {
        guard email.contains("@") else { throw AuthError.nonEmail }
        guard email.count > 7 else { throw AuthError.tooShort }
        self.wrapped = email
    }
    
    static func parse(_ email: String) -> Result<Email, Error> {
        
        Result {
            guard email.contains("@") else { throw AuthError.nonEmail }
            guard email.count > 7 else { throw AuthError.tooShort }
            
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
        guard password.count > 8 else { return nil }
        self.wrapped = password
    }
    
    init(from password: String) throws {
        guard password.count > 8 else { throw AuthError.tooShort }
        self.wrapped = password
    }
    
    static func parse(_ password: String) -> Result<Password, Error> {
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
    
    init(from email: String, from password: String) throws {
        guard let email = Email(email),
              let password = Password(password)
        else { throw AuthError.wrongCredentials  }
        
        self.email = email
        self.password = password
    }
    
    static func parse(
        email: String,
        password: String
    ) -> Result<Credentials, Error> {
        Result.zip(
            Email.parse(email),
            Password.parse(password)
        )
        .map(Credentials.init)
    }
}


