//
//  SignUpView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 06.09.2024.
//

import SwiftUI

struct SignUpView: View {
    typealias Action = () -> Void
    
    //MARK: - Properties
    @Binding var name: String
    @Binding var email: String
    @Binding var password: String
    
    let didTapRegisterButton: Action
    let didTapSignInButton: Action
    
    let localization: Localization
    
    //MARK: - Drawing
    private enum Drawing {
        static let playIconFrame = CGSize(width: /*@START_MENU_TOKEN@*/58.0/*@END_MENU_TOKEN@*/, height: 58)
    }
    
    //MARK: - Body
    var body: some View {
        MainBackground {
            Image(.playLabel)
                .resizable()
                .frame(
                    width: Drawing.playIconFrame.width,
                    height: Drawing.playIconFrame.height)
            
            Text(localization.SignIn)
                .applyFonts(for: .largeTitle)
            Text(localization.startPlay)
                .applyFonts(for: .buttonText)
                .padding(.bottom)
            
            CustomAuthTextField(
                text: $email,
                placeholder: localization.yourName,
                labelText: localization.name)
            .padding(.bottom)
            
            CustomAuthTextField(
                text: $email,
                placeholder: localization.yourEmail,
                labelText: localization.email)
            .keyboardType(.emailAddress)
            .padding(.bottom)
            
            CustomAuthTextField(
                text: $password,
                placeholder: localization.yourPassword,
                labelText: localization.password,
                isSecured: true)
            .padding(.bottom)
            
            ArrowButton(action: didTapRegisterButton)
            
            Button(action: didTapSignInButton) {
                Text(localization.signUp)
                    .applyFonts(for: .lightSystemText)
            }
        }
    }
}
#warning("Локализацию такую оставить?")
extension SignUpView {
    struct Localization {
        let SignIn: String
        let startPlay: String
        let yourPassword: String
        let yourEmail: String
        let yourName: String
        let email: String
        let name: String
        let password: String
        let signUp: String
        
        static let develop = Self(
            SignIn: "Sign up",
            startPlay: "To start play",
            yourPassword: "Your password",
            yourEmail: "Your email",
            yourName: "Your name",
            email: "Email",
            name: "Name",
            password: "Password",
            signUp: "Or Sign In"
            
        )
        
        static let russianDevelop = Self(
            SignIn: "Войти",
            startPlay: "Начать играть",
            yourPassword: "Ваш пароль",
            yourEmail: "Ваш email", 
            yourName: "Ваше имя",
            email: "Электронная почта",
            name: "Имя",
            password: "Пароль",
            signUp: "Или зарегистрируйтесь"
        )
    }
}

#Preview {
    MainBackground {
        SignUpView(
            name: .constant("Ivan"),
            email: .constant("email@mail.ru"),
            password: .constant("qwerty"),
            didTapRegisterButton: {},
            didTapSignInButton: {}, 
            localization: .develop
        )
    }
}
