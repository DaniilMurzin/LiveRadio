//
//  TabBarContentView.swift
//  RadioApp
//
//  Created by Daniil Murzin on 04.11.2025.
//
import SwiftUI

struct TabBarContentView: View {
    @StateObject var viewModel: TabBarViewModel

    init(_ vm: TabBarViewModel) {
        _viewModel = StateObject(wrappedValue: vm)
    }

    var body: some View {
        TabBarView(
            selected: Binding(
                get: { viewModel.selectedTab },
                set: { viewModel.selectedTab = $0 }
            ),
            onPopular: viewModel.showPopular,
            onFavorites: viewModel.showFavorites,
            onAllStations: viewModel.showAllStations
        )
    }
}
