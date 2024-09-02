//
//  PopularContentView.swift
//  LiveRadioApp
//
//  Created by Шаповалов Илья on 30.08.2024.
//

import SwiftUI

struct PopularContentView: View {
    
    //MARK: - Properties
    @StateObject var viewModel: PopularViewModel
    
    //MARK: - init(_:)
    init(viewModel: PopularViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    //MARK: - body
    var body: some View {
        EmptyView()
    }
}
