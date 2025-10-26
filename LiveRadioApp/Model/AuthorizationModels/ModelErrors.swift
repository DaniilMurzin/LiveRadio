//
//  ModelErrors.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 26.10.2025.
//


enum EmailError: Error {
    case tooShort
    case nonEmail
}

enum NameError: Error {
    case tooShort
}
