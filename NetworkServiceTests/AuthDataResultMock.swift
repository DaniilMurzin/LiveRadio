//
//  AuthDataResultMock.swift
//  NetworkServiceTests
//
//  Created by Daniil Murzin on 09.12.2024.

import Foundation
import FirebaseAuth

// Протокол для абстрагирования AuthDataResult
protocol AuthDataResultProtocol {
    var user: UserProtocol { get }
}


//class AuthDataResultMock: AuthDataResult {
//    init(user: FirebaseAuth.User) {
//        super.init(withUser: user, additionalUserInfo: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        guard let user = coder.decodeObject(of: FirebaseAuth.User.self, forKey: "user") else {
//            return nil
//        }
//        super.init(coder: coder, withUser: user, additionalUserInfo: nil)
//    }
//    
//    override func encode(with coder: NSCoder) {
//        super.encode(with: coder)
//        coder.encode(user, forKey: "user")
//    }
//}

protocol UserProtocol {
    var uid: String { get }
    var email: String? { get }
}


extension FirebaseAuth.User: UserProtocol {}

final class UserMock: UserProtocol {
    var uid: String
    var email: String?
    
    init(uid: String, email: String?) {
        self.uid = uid
        self.email = email
    }
}
