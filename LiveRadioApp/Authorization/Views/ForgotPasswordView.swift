//
//  ForgotPasswordView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 06.09.2024.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    //MARK: - Properties
    @Binding  var email: String
    @Binding  var password: String
    
    let didTapBackButton: () -> Void
    
    //MARK: - Drawing
    private enum Drawing {
        
        static let forgotPassword = "Forgot password"
        static let yourEmail = "Your email"
        static let email = "Email"
        static let signUp = "Or Sign In"
        static let sent = "Sent"
        
        static let mainVStackPadding: CGFloat = 40
    }
    
    //MARK: - Body
    var body: some View {
        MainBackground {
            BackButton(action: didTapBackButton)
            
            Text(Drawing.forgotPassword)
                .applyFonts(for: .largeTitle)
                .padding(.bottom)
            
            CustomAuthTextField(
                text: $email,
                placeholder: Drawing.yourEmail,
                labelText: Drawing.email)
            .keyboardType(.emailAddress)
            .padding(.bottom)
            
            CustomButtonAuth(title: Drawing.sent)
                .padding(.top)
            
            Spacer()
        }
    }
}


#Preview {
    MainBackground {
        ForgotPasswordView(
            email: .constant("email@mail.ru"),
            password: .constant("qwerty"),
            didTapBackButton: {})
    }
}
