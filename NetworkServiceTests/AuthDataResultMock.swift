//
//  AuthDataResultMock.swift
//  NetworkServiceTests
//
//  Created by Daniil Murzin on 09.12.2024.

import Foundation
//import FirebaseAuth


final class AuthDataResultMock {
    let user: UserMock

    init(user: UserMock) {
        self.user = user
    }
}

final class UserMock {
    let uid: String
    let email: String?

    init(uid: String, email: String?) {
        self.uid = uid
        self.email = email
    }
}
