//
//  SettingsView.swift
//  RadioApp
//
//  Created by Daniil Murzin on 27.07.2025.
//

import SwiftUI

import SwiftUI

struct SettingsView: View {
    
    let didTapLanguage: Action
    let didTapLogout: () -> Void
    let didTapNotification: () -> Void
    let
    @Binding var toggleNotification: Bool

    var body: some View {
        MainBackground {
            VStack(spacing: 20) {
                ProfileHeader(action: {})

                List {
                    Section {
                        SettingsProfileRow()
                    }

                    Section {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("General")
                                .foregroundColor(.white)
                                .applyFonts(for: .bodyText)

                            NotificationToggle(isOn: $toggleNotification)

                            Divider()
                                .background(Color.white.opacity(0.2))

                            SettingsItemRow(
                                title: "Language",
                                icon: "globe",
                                action: didTapLanguage
                            )
                        }
                        .padding()
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white.opacity(0.2), lineWidth: 2)
                    )
                    .listRowBackground(Color.clear)

                    Section {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("More")
                                .foregroundColor(.white)
                                .applyFonts(for: .bodyText)

                            SettingsItemRow(
                                title: "Legal and Policies",
                                icon: "shield.fill"
                            )

                            Divider()
                                .background(Color.white.opacity(0.2))

                            SettingsItemRow(
                                title: "About Us",
                                icon: "info.circle"
                            )
                        }
                        .padding()
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white.opacity(0.2), lineWidth: 2)
                    )
                    .listRowBackground(Color.clear)
                }
                .listStyle(.plain)
                .background(Color.clear)
                ProfileActionButton(title: "Log Out", action: {})
            }
           
            .padding(.top, 8)
        }
    }
}

#Preview {
    SettingsView(toggleNotification: .constant(true))
}
