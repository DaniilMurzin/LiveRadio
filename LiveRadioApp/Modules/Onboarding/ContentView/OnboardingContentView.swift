//
//  OnboardingContentView.swift
//  LiveRadioApp
//
//  Created by Шаповалов Илья on 30.08.2024.
//


// Отвечет на каком шаге мы находимся онбординга 
import SwiftUI

struct OnboardingContentView: View {
    @StateObject var viewModel: OnboardingViewModel
    
    init(_ viewModel: OnboardingViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        OnboardingView()

    }
}
