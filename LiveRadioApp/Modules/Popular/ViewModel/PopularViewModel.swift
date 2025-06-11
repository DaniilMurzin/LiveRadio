//
//  PopularViewModel.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 30.08.2024.
//

import SwiftUI

final class PopularViewModel: ObservableObject {
    
    //MARK: - Properties
    private let networkService: StationDataService
    private let storageManager: StorageManager
    private let avPlayer: RadioPlayer

    @Published var fetchedStations: [LocalStation] = []
    @Published var name: String = "Daniil"
    @Published var selectedStation: LocalStation?
    
    @Published var volume: Double = 0.5 {
           didSet { avPlayer.volume = volume }
       }
    
    var isPlaying: Binding<Bool> {
        Binding (
            get: { self.avPlayer.isPlaying },
            set: { self.avPlayer.isPlaying = $0}
        )
    }
    
    //MARK: - Init
    init(
        networkService: StationDataService,
        avPlayer: RadioPlayer,
        storageManager: StorageManager
    ) {
        self.networkService = networkService
        self.avPlayer = avPlayer

        self.storageManager = storageManager
    }

    //MARK: - Network Methods
    @Sendable
    func fetchPopularStations() async {
        do {
            async let stations = try await networkService.fetchTop()
            async let stored = try await storageManager.loadAllStations()
            
            let localStations = try await [LocalStation](fetched: stations, stored: stored)
            
            await MainActor.run { self.fetchedStations = localStations }
            
        } catch {
            print("Ошибка загрузки станций: \(error.localizedDescription)")
        }
    }

    //MARK: - Player Logic methods
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
