//
//  Models.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 26.09.2024.
//

import Foundation
#warning("Модель по разным файлам распределить")
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
        .failure(.toShort)
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

#warning("Не понял зачем здесь прайвет инит? чтобы через статик методы создавать юзера?")
struct User {
    init(id: String, email: String) {
        self.id = id
        self.email = email
    }
    
    let id: String
    let email: String
}

enum EmailError: Error {
    case toShort
    case nonEmail
}