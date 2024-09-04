//
//  Fonts.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 30.08.2024.
//

import SwiftUI

//struct Fonts {
//    static let largeTitle = Font.system(size: 52, weight: .bold)
//    static let bodyText = Font.system(size: 16, weight: .regular)
//    static let buttonText = Font.system(size: 20, weight: .bold)
//}

struct CustomFontModifier: ViewModifier {
    
    enum AppFonts {
        case largeTitle
        case bodyText
        case buttonText
        case textFiledText
        case montserratSmall
    }
    
    var font: AppFonts
    
    func body(content: Content) -> some View {
        content
            .font(selectFont(for: font))
            .foregroundStyle(.white)
    }
    
    private func selectFont(for font: AppFonts) -> Font {
        switch font {
        case .largeTitle:
            Font.system(size: 52, weight: .bold)
        case .bodyText:
            Font.system(size: 16, weight: .regular)
        case .buttonText:
            Font.system(size: 20, weight: .bold)
        case .textFiledText:
            Font.system(size: 16, weight: .light, design: .default)
        case .montserratSmall:
            Font.custom("Montserrat-Italic", size: 11)
        }
        
    }
}

extension View {
    func applyFonts(for font: CustomFontModifier.AppFonts ) -> some View {
        self.modifier(CustomFontModifier(font: font))
    }
}
