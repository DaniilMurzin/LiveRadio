//
//  LocalUser.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 29.10.2025.
//

import Foundation

struct LocalUser: Equatable {
    
    typealias ID = AppUser.ID
    
    let id: ID
    let email: Email?
    let name: UserName?
    let photoURL: URL?
    
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
            id: db.userId,
            email: db.email.flatMap(Email.init),
            name: db.name.flatMap(UserName.init),
            photoURL: db.photoURL.flatMap(URL.init)
        )
    }
}
