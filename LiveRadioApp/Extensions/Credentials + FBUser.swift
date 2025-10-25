//
//  Credentials + FBUser.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 25.10.2025.
//


extension Credentials {
    var credentials: (email: String, password: String) {
        (email.wrapped, password.wrapped)
    }
}