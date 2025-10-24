//
//  ProfileContentView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 24.08.2025.
//

import SwiftUI


final class ProfileContentView: View {
    
    @StateObject var viewModel: ProfileViewModel
    
    init(_ viewModel: ProfileViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        SettingsView(
            didTapLanguage: {},
            didTapLogout: {},
            didTapNotification: {},
            isNotificationOn: $viewModel.notificationEnabled
        )
        .task { await self.viewModel.loadCurrentUser() }
    }
}
