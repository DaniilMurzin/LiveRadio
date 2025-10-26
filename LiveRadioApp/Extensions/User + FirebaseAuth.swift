//
//  LocalUser + AuthUser.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 25.10.2025.
//

import FirebaseAuth

extension LocalUser {
    init(_ firebaseUser: FirebaseAuth.User) {
        self.init(
            id: ID(rawValue: firebaseUser.uid),
            email: firebaseUser.email ?? "",
            name: firebaseUser.displayName ?? "" ,
            photoURL: firebaseUser.photoURL?.absoluteString ?? ""
        )
    }
}
