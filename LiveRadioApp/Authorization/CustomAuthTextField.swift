//
//  CustomAuthTextFiled.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 04.09.2024.
//

import SwiftUI

struct CustomAuthTextField: View {
    
    @Binding var text: String
    var placeholder: String
    
    init(text: Binding<String>, placeholder: String) {
        self._text = text
        self.placeholder = placeholder
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color.white.opacity(0.5))
                    .padding(.leading, 10)
            }
            
            TextField("", text: $text)
                .padding()
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.ellipse8, lineWidth: 2)
                        .shadow(color: .ellipse8, radius: 5, x: 2, y: 2)
                )
                .applyFonts(for: .textFiledText)
                .foregroundColor(Color.white.opacity(0.5))
                .shadow(color: .ellipse8, radius: 10, x: 4, y: 4)
                .frame(width: 330, height: 53)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
        }
    }
}

struct CustomAuthTextField_Previews: PreviewProvider {
    static var previews: some View {
        @State var emailText = ""
        
        CustomAuthTextField(text: $emailText, placeholder: "Your Email")
            .background(Color.mainBg)
    }
}


//#Preview {
//    @State var emailText = "Email"
//    CustomAuthTextField(text: $emailText, placeholder: "Your Email")
//}
