//
//  Models.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 26.09.2024.
//

import Foundation

#warning("Гарды через фейлебл инит или истинность через функцию parse")

struct UserName: Equatable {
    let wrapped: String
    
    init?(_ name: String) { self.wrapped = name }
    
    private init(wrapped: String) { self.wrapped = wrapped}
    
    static func parse(_ name: String) -> Result<UserName, Error> {
        
        Result {
            guard name.count > 3 else { throw NameError.tooShort }
            
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
        self.wrapped = email
    }
    
    static func parse(_ email: String) -> Result<Email, Error> {
        
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

struct LocalUser: Equatable {
    
    typealias ID = Identifier<LocalUser, String>
    
    let id: ID
    let email: Email?
    let name: UserName?
    let photoURL: URL?
    var dbUserId: DBUser.ID  { DBUser.ID(rawValue: id.rawValue)}
    
    init(
        id: ID,
        email: Email?,
        name: UserName?,
        photoURL: URL?
    ) {
        self.id = id
        self.email = email
        self.name = name
        self.photoURL = photoURL
    }
    
    init(db: DBUser) {
        self.init(
            id: ID(rawValue: db.userId.rawValue),
            email: db.email.flatMap(Email.init),
            name: db.name.flatMap(UserName.init),
            photoURL: db.photoURL.flatMap(URL.init)
        )
    }
}
