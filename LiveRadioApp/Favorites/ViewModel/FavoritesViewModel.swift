//
//  FavoritesViewModel.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 23.12.2024.
//

import Foundation

final class FavoritesViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var isPlaying: Bool = false
    @Published var isFavorite: Bool = false
}
