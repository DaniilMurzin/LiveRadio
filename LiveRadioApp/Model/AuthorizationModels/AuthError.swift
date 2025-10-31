//
//  AuthError.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 26.10.2025.
//


enum AuthError: Error {
    case tooShort
    case nonEmail
    case wrongPasswordFormat
    case wrongPassword
    case wrongCredentials
    case wrongEmail
    case emptyField
    case unknown
}
