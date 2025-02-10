//
//  PopularViewModel.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 30.08.2024.
//

import SwiftUI

final class PopularViewModel: ObservableObject {
    
    private let networkService: StationDataService
    private let storageManager: StorageManager
    var avPlayer: RadioPlayer

    @Published var fetchedStations: [LocalStation] = []
    @Published var name: String = "Daniil"
    @Published var selectedStation: LocalStation?
    
    @Published var volume: Double = 0.5 {
           didSet { avPlayer.volume = volume }
       }
    
    init(
        networkService: StationDataService,
        avPlayer: RadioPlayer,
        storageManager: StorageManager
    ) {
        self.networkService = networkService
        self.avPlayer = avPlayer

        self.storageManager = storageManager
    }
#warning("Ревью + LocalStation model + AsyncMap TaskGroup есть смысл использовать?")
    @Sendable
    func fetchPopularStations() async {
        do {
            let stations = try await networkService.fetchTop()
            
            let localStations = try await stations.asyncMap {
                LocalStation(
                    dto: $0,
                    isFavorite: try await storageManager.contains($0)
                )
            }
            
            await MainActor.run { self.fetchedStations = localStations }
            
        } catch {
            print("Ошибка загрузки станций: \(error.localizedDescription)")
        }
    }

    
    func handleSelection(_ station: LocalStation) {
        defer {
            selectedStation = avPlayer.currentStation
        }
        if avPlayer.currentStation == station {
            avPlayer.isPlaying.toggle()
            return
        }
        avPlayer.play(stations: fetchedStations) { $0 == station }
    }

    func playNextStation() {
        avPlayer.playNext()
        selectedStation = avPlayer.currentStation
    }

    func playPreviousStation() {
        avPlayer.playPrevious()
        selectedStation = avPlayer.currentStation
    }
    
    @MainActor
    func toggleFavorite(for station: LocalStation) async {
            do {
                let contains = try await storageManager.contains(station)
                if let index = fetchedStations.firstIndex(of: station) {
                    fetchedStations[index].isFavorite.toggle()
                }

                if contains {
                    try await storageManager.removeStation(station)
                } else {
                    try await storageManager.saveStation(station)
                }
                
            } catch {
                print("Ошибка при переключении избранного: \(error.localizedDescription)")
            }
        }

    func didTapPlayButton() {
        if let selectedStation = selectedStation {
            handleSelection(selectedStation)
        }
    }
    
    func onAppear()  {
        guard let currentStation = avPlayer.currentStation  else { return }
               selectedStation = currentStation
           }
    }
