//
//  SignInView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 27.08.2024.
//

#warning("Naming пропертис?")
#warning("Дебаггинг пэдингов - консоль")

import SwiftUI

struct SignInView: View {
    
    //MARK: - Properties
    @State private var emailText = ""
    @State private var passwordText = ""
    
    //MARK: - Drawing
    private enum Drawing {
        static let SignIn = "Sign in"
        static let startPlay = "To start play"
        static let yourPassword = "Your password"
        static let yourEmail = "Your email"
        static let email = "Email"
        static let password = "Password"
        static let forgotPassword = "Forgot password?"
        static let connect = "Or connect with"
        static let signUp = "Or Sign Up"
        
        static let playIconFrame = CGSize(width: /*@START_MENU_TOKEN@*/58.0/*@END_MENU_TOKEN@*/, height: 58)
        static let circleFrame = CGSize(width: 40, height: 40)
        static let signInButtonFrame = CGSize(width: 153, height: 62)
        
        static let VStamainckHorizontalPadding: CGFloat = 40
        static let bottomPadding: CGFloat = 30
        static let signUpButtonPadding: CGFloat = 5
    }
    
    //MARK: - Body
    var body: some View {
        
        ZStack {
            Image(.authBG)
                .resizable()
                .ignoresSafeArea()
            VStack(alignment: .leading) {
//                Spacer()
                appLogo
                titleText
                textFields
                forgotPasswordButton
                separator
                signInButton
                signUpButton
//                Spacer()
            }
            .padding(.horizontal, Drawing.VStamainckHorizontalPadding)
        }
        .background(Color.mainBg)
        
    }
    
    //MARK: - Subviews
    private var appLogo: some View {
        Image(.playLabel).resizable()
            .frame(width: Drawing.playIconFrame.width,
                   height: Drawing.playIconFrame.height)
            .padding(.top)
    }
    
    private var titleText: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(Drawing.SignIn)
                .applyFonts(for: .largeTitle)
            Text(Drawing.startPlay)
                .applyFonts(for: .buttonText)
                .padding(.bottom)
        }
    }
    
    private var subtitleText: some View {
        Text(Drawing.startPlay)
            .applyFonts(for: .bodyText)
    }
    
    private var textFields: some View {
        VStack {
            CustomAuthTextField(
                text: $emailText,
                placeholder: Drawing.yourEmail,
                labelText: Drawing.email)
                .keyboardType(.emailAddress)
                .padding(.bottom)
            
            CustomAuthTextField(text: $passwordText, placeholder: Drawing.yourPassword, labelText: Drawing.password, isSecured: true)
                .padding(.bottom)
        }
    }
    
    private var forgotPasswordButton: some View {
        Button( action: {
            
        } ) {
            Text(Drawing.forgotPassword)
                .foregroundStyle(.gray)
                .padding(.bottom)
        }
    }
    
    private var separator: some View {
        VStack {
            
            HStack(spacing: 10) {
                
                Rectangle().frame(height: 1)
                    .foregroundStyle(.ellipse9)
                Text(Drawing.connect)
                    .foregroundStyle(.ellipse9)
                    .lineLimit(1)
                    .applyFonts(for: .montserratSmall)
                Rectangle().frame( height: 1)
                    .foregroundStyle(.ellipse9)
            }
            .padding(.bottom)
            .padding(.horizontal,Drawing.VStamainckHorizontalPadding)
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Circle()
                    .frame(width: Drawing.circleFrame.width,
                           height: Drawing.circleFrame.height)
                    .foregroundStyle(.googleIcon)
                    .overlay (
                        Image(.googlePlus)
                    )
                    .padding(.bottom)
            }
        }
    }
    
    private var signInButton: some View {
        Button(action: {}) {
            Rectangle()
                .frame(width: Drawing.signInButtonFrame.width,
                       height: Drawing.signInButtonFrame.height)
                .overlay {
                    Image(.vector).aspectRatio(contentMode: .fit)
                }
                .padding(.bottom, Drawing.signUpButtonPadding)
        }
    }
    
    private var signUpButton: some View {
        Button( action: {} ) {
            Text(Drawing.signUp)
                .applyFonts(for: .lightSystemText)

        }
        .padding(.bottom, Drawing.bottomPadding)
    }
}

//MARK: - Preview
#Preview {
    SignInView()
}
