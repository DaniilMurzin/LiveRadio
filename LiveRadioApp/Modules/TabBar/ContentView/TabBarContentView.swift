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
        TabBarView(selected: $viewModel.selected) { tab in
            viewModel.coordinator.makeContent(for: tab)
        }
    }
}
