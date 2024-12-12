//
//  PopularViewModel.swift
//  LiveRadioApp
//
//  Created by Шаповалов Илья on 30.08.2024.
//

import Foundation

final class PopularViewModel: ObservableObject {
    
    //MARK: - Properties
    let networkService: StationDataService
    @Published var fetchedStations: [Station] = .init()
    @Published var name: String = .init()
    @Published var volume: Double = 0
    
    init(networkService: StationDataService) {
        self.networkService = networkService
    }

    //MARK: - Network
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
