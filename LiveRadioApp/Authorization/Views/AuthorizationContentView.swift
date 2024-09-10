//
//  AuthorizationContentView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 08.09.2024.
//

import SwiftUI

struct AuthorizationContentView: View {
    
    @StateObject var viewModel: AuthorizationViewModel
    
    init(_ viewModel: AuthorizationViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
      SignInView()
    }
}

#Preview {
    SignInView()
}
