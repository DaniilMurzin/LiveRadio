//
//  CustomAuthTextFiled.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 04.09.2024.
//
#warning("Не знаю, как от вложенности избавиться")
#warning("Ошибки в консоль по нажатию на показать пароль")
import SwiftUI

struct CustomAuthTextField: View {
    
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
                            .stroke(Color.ellipse8, lineWidth: 2)
                            .shadow(color: .ellipse8, radius: 5, x: 2, y: 2)
                    )
                    .applyFonts(for: .textFiledText)
                    .foregroundColor(Color.white.opacity(0.5))
                    .shadow(color: .ellipse8, radius: 10, x: 4, y: 4)
                    .frame(width: 330, height: 53)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    
                } else {
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
    }
    
#warning("Почему превью только так работает?")

}

struct CustomAuthTextField_Previews: PreviewProvider {
    static var previews: some View {
        @State var emailText = ""
        
        CustomAuthTextField(text: $emailText, placeholder: "Your Email", labelText: "Email", isSecured: true)
            .background(Color.mainBg)
    }
}
//#Preview {
//    @State var emailText = "Email"
//    CustomAuthTextField(text: $emailText, placeholder: "Your Email")
//}
