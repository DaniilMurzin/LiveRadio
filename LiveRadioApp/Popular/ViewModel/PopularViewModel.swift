//
//  PopularViewModel.swift
//  LiveRadioApp
//
//  Created by Шаповалов Илья on 30.08.2024.
//

import Foundation

final class PopularViewModel: ObservableObject {
    
    //MARK: - Properties
    let networkService: NetworkService
    @Published var fetchedStations: [Station] = .init()
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func fetchPopularStations() {
        Task {
            do {
                let stations = try await networkService.fetchTop()
                
                await MainActor.run {
                    self.fetchedStations = stations
                }
            } catch {
                print("Ошибка загрузки станций: \(error.localizedDescription)")
            }
        }
    }
}
