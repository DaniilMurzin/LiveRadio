//
//  AllStationsContentView.swift
//  RadioApp
//
//  Created by Daniil Murzin on 12.02.2025.
//

import SwiftUI

struct AllStationsContentView: View {
    
    @StateObject var viewModel: AllStationsViewModel
    
    init(_ viewModel: AllStationsViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Text("Hello, World!")
//        AllStationsView()
//        .task(viewModel.fetchPopularStations)
//        .onAppear(perform: viewModel.onAppear)
    }
}
