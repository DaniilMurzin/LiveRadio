//
//  OnboardingViewModel.swift
//  LiveRadioApp
//
//  Created by Шаповалов Илья on 30.08.2024.
//

import Foundation

protocol Repository {
    func fetchOnboarding() async -> [String]
}

final class OnboardingViewModel: ObservableObject {
    private let repository: Repository
    
    @Published var onboarding: [String] = .init()

    init(repository: Repository) {
        self.repository = repository
    }
    
    @MainActor
    func onAppear() async {
        self.onboarding = await repository.fetchOnboarding()
    }
    
}
