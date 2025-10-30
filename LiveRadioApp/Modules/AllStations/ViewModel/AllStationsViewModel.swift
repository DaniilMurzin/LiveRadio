//
//  AllStationsViewModel.swift
//  RadioApp
//
//  Created by Daniil Murzin on 12.02.2025.
//

import SwiftUI

final class AllStationsViewModel: ObservableObject {
    
    //MARK: - Properties
    private let networkService: StationDataService
    private let storageManager: StorageService
    private let avPlayer: RadioPlayer
    
    @Published var fetchedStations: [LocalStation] = []
    @Published var name: String = "Daniil"
    @Published var selectedStation: LocalStation?
    @Published var searchText: String = ""
    @Published var volume: Double
    
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
        storageManager: StorageService
    ) {
        self.networkService = networkService
        self.avPlayer = avPlayer
        self.volume = avPlayer.volume
        self.storageManager = storageManager
    }
    
    //MARK: - Network Methods
    @Sendable
    func searchByName() async {
        do {
            async let stations = try await networkService.searchByName(name: searchText )
            async let stored = try await storageManager.loadAllStations()
            
            let localStations = try await [LocalStation](fetched: stations, stored: stored)
            
            await MainActor.run { self.fetchedStations = localStations }
            
        } catch {
            print("Ошибка загрузки станций: \(error.localizedDescription)")
        }
    }
    
    //MARK: - avPlayer methods
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
    
    func didTapPlayButton() {
        guard let selectedStation else { return }
        handleSelection(selectedStation)
    }
    
    func playNextStation() {
        avPlayer.playNext()
        selectedStation = avPlayer.currentStation
    }
    
    func playPreviousStation() {
        avPlayer.playPrevious()
        selectedStation = avPlayer.currentStation
    }
    
    func onAppear()  {
        guard let currentStation = avPlayer.currentStation  else { return }
        selectedStation = currentStation
    }
    
    //MARK: - Favorites logic
    @MainActor
    func toggleFavorite(for station: LocalStation) async {
            do {
                let contains = try await storageManager.contains(station)
               
                if contains {
                    try await storageManager.removeStation(station)
                } else {
                    try await storageManager.saveStation(station)
                }
                
                if let index = fetchedStations.firstIndex(of: station) {
                    fetchedStations[index].isFavorite.toggle()
                }
                
            } catch {
                print("Ошибка при переключении избранного: \(error.localizedDescription)")
            }
        }

    @MainActor
    @Sendable
    func fetchFavoriteStations() async {
        do {
            let stations = try await storageManager.loadStations(nil)
            self.fetchedStations = stations
        } catch {
            print("Ошибка загрузки избранных станций: \(error.localizedDescription)")
        }
    }
}
