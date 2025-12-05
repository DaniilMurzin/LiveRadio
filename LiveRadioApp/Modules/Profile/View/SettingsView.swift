//
//  SettingsView.swift
//  RadioApp
//
//  Created by Daniil Murzin on 27.07.2025.
//

import SwiftUI

import SwiftUI

struct SettingsView: View {
    
    let didTapLanguage: () -> Void
    let didTapLogout: () -> Void
    let didTapNotification: () -> Void
    @Binding var isNotificationOn: Bool

    var body: some View {
        MainBackground {
            VStack(spacing: 20) {
                

                List {
                    Section {
                        SettingsProfileRow()
                    }

                    Section {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("General")
                                .foregroundColor(.white)
                                .applyFonts(for: .bodyText)

                            NotificationToggle(isOn: $isNotificationOn)

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
                                icon: "shield.fill", action: {}
                            )

                            Divider()
                                .background(Color.white.opacity(0.2))

                            SettingsItemRow(
                                title: "About Us",
                                icon: "info.circle", action: {}
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
    SettingsView(
        didTapLanguage: {
        },
        didTapLogout: {},
        didTapNotification: {},
        isNotificationOn: .constant(false)
    )
}
