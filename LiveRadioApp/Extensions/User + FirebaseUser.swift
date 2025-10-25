//
//  File.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 25.10.2025.
//

import FirebaseAuth

extension User {
    init(_ firebaseUser: FirebaseAuth.User) {
        self.init(
            id: firebaseUser.uid,
            email: firebaseUser.email ?? "",
            name: firebaseUser.displayName ?? "" ,
            photoURL: firebaseUser.photoURL?.absoluteString ?? ""
        )
    }
}
