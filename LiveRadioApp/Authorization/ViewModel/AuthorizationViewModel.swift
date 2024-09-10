//
//  AuthorizationViewModel.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 08.09.2024.
//

import Foundation


final class AuthorizationViewModel: ObservableObject {
    
    enum AuthorizationState {
        case signIn, signUp, forgotPass, forgotPass2
    }
    
    @Published var currentAuthorizationState: AuthorizationState = .signIn
}
