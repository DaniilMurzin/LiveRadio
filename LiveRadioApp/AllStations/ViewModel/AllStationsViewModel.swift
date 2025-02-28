//
//  AllStationsViewModel.swift
//  RadioApp
//
//  Created by Daniil Murzin on 12.02.2025.
//

import SwiftUI

final class AllStationsViewModel: ObservableObject {
    
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
    
    init(
        networkService: StationDataService,
        avPlayer: RadioPlayer,
        storageManager: StorageManager
    ) {
        self.networkService = networkService
        self.avPlayer = avPlayer
        self.storageManager = storageManager
    }
}
