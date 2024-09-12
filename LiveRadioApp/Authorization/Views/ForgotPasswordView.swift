//
//  ForgotPasswordView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 06.09.2024.
//

import SwiftUI

struct ForgotPasswordView: View {
        
        //MARK: - Properties
        @State private var emailText = ""
        @State private var passwordText = ""
        
        //MARK: - Drawing
        private enum Drawing {
            
            static let forgotPassword = "Forgot password"
            static let yourEmail = "Your email"
            static let email = "Email"
            static let signUp = "Or Sign In"
            static let sent = "Sent"
            
            static let signInButtonFrame = CGSize(width: 153, height: 62)
            
            static let mainVStackPadding: CGFloat = 40
            static let labelPadding: CGFloat = 0
        }
        
        //MARK: - Body
        var body: some View {
            
            ZStack {
                Image(.authBG)
                VStack(alignment: .leading) {
                    Spacer()
                    BackButton()
                    titleText
                    textFields
                    Spacer()
                    signInButton
                    Spacer()
                    
                }
                .padding(.horizontal, Drawing.mainVStackPadding)
            }
            .background(Color.mainBg)
        }
        
        //MARK: - Subviews

        private var titleText: some View {
            VStack(alignment: .leading, spacing: 2) {
               
                Text(Drawing.forgotPassword)
                    .applyFonts(for: .largeTitle)
                    .padding(.bottom, 40)
            }
        }
        
        
        private var textFields: some View {
            VStack {
                CustomAuthTextField(
                    text: $emailText,
                    placeholder: Drawing.yourEmail,
                    labelText: Drawing.email)
                    .keyboardType(.emailAddress)
                    .padding(.bottom)

            }
            .padding(.bottom)
        }
        
        private var signInButton: some View {
            CustomButtonAuth(title: Drawing.sent)
                
        }
    }

#Preview {
    ForgotPasswordView()
}
