//
//  AuthorizationViewModel.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 08.09.2024.
//

import Foundation

final class AuthorizationViewModel: ObservableObject {
    @Published var state: State = .signIn
    @Published var email: String = .init()
    @Published var password: String = .init()
    @Published var name: String = .init()
    
    func forgotPassword() {
        state = .forgotPass
    }
    
    func signIn() {
        state = .signIn
    }
    
    func signUp() {
        state = .signUp
    }
}

extension AuthorizationViewModel {
    //MARK: - State
    enum State {
        case signIn, signUp, forgotPass, forgotPass2
    }
}
