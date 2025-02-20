//
//  CustomAuthTextFiled.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 04.09.2024.
//

import SwiftUI

struct AuthTextField: View {
    
    @Binding var text: String
    var placeholder: String
    var labelText: String
    var isSecured: Bool = true
    @State private var isPasswordHide: Bool = true
    
    init(text: Binding<String>, placeholder: String, labelText: String, isSecured: Bool = false ) {
        self._text = text
        self.placeholder = placeholder
        self.labelText = labelText
        self.isSecured = isSecured
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(labelText)
                .applyFonts(for: .bodyText)
            
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(Color.white.opacity(0.5))
                        .padding(.leading, 10)
                }
                
                if isSecured {
                    HStack {
                        if isPasswordHide {
                            SecureField("", text: $text)
                                .padding()
                                
                        } else {
                            TextField("", text: $text)
                                .padding()
                        }
                    
                        Button(action: {
                            isPasswordHide.toggle()
                        }) {
                            Image(systemName: isPasswordHide ? "eye.slash" : "eye")
                                .foregroundColor(.gray)
                        }
                        .padding(.trailing, 16)
                    }
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.eclipse8, lineWidth: 2)
                            .shadow(color: .eclipse8, radius: 5, x: 2, y: 2)
                    )
                    .applyFonts(for: .textFiledText)
                    .foregroundColor(Color.white.opacity(0.5))
                    .shadow(color: .eclipse8, radius: 10, x: 4, y: 4)
                    .frame(width: 330, height: 53)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    
                } else {
                    TextField("", text: $text)
                        .padding()
                        .cornerRadius(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.eclipse8, lineWidth: 2)
                                .shadow(color: .eclipse8, radius: 5, x: 2, y: 2)
                                
                        )
                        .applyFonts(for: .textFiledText)
                        .foregroundColor(Color.white.opacity(0.5))
                        .shadow(color: .eclipse8, radius: 10, x: 4, y: 4)
                        .frame(width: 330, height: 53)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        
                }
            }
        }
    }
}

struct CustomAuthTextField_Previews: PreviewProvider {
    static var previews: some View {
        @State var emailText = ""
        
        AuthTextField(text: $emailText, placeholder: "Your Email", labelText: "Email", isSecured: true)
            .background(Color.mainBg)
    }
}
