//
//  Models.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 26.09.2024.
//

import Foundation
// Only Valid email!!!
struct Email: Equatable {
    let wrapped: String
    
    init?(_ email: String) {
        guard email.contains("@") && email.count > 7 else {
            return nil
        }
        self.wrapped = email
    }
    
    static func parce(_ email: String) -> Result<Email, EmailError> {
        .failure(.tooShort)
    }
}

struct Password: Equatable {
    let wrapped: String
    
    init?(_ password: String) {
        guard password.count > 8 else {
            return nil
        }
        self.wrapped = password
    }
}

// Valid!!!
struct Credentials: Equatable {
    let email: Email
    let password: Password
}

struct User: Equatable {
    init(id: String, email: String) {
        self.id = id
        self.email = email
    }
    
    let id: String
    let email: String
}

enum EmailError: Error {
    case tooShort
    case nonEmail
}
