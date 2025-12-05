//
//  TabBarView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 16.09.2024.
//

import SwiftUI

struct TabBarView: View {
    
    @Binding var isPlaying: Bool
    let didTapPlayButton: Action
    let didTapBackwardButton: Action
    let didTapForwardButton: Action
    let didTapProfileButton: Action
    let name: UserName?
    @Binding var selected: Tab

    var tabs: [Tab] = Tab.allCases
    let content: (Tab) -> AnyView
    
    var body: some View {
        TabBarBackground {
            HeaderView(
                name: name?.wrapped ?? "User",
                didTapProfileButton: didTapProfileButton
            )
                .padding()
            content(selected)
            HStack(alignment: .bottom) {
                ForEach(tabs, id: \.self) { tab in
                    TabBarButton(
                        tab: tab,
                        title: tab.title,
                        action: { selected = tab },
                        isSelected: tab == selected
                    )
                    .equatable()
                }
                .padding(.horizontal, 20)
            }
        }
        .overlay(
            VStack {
                Spacer()
                PlayerView(
                    isPlaying: $isPlaying,
                    backwardButtonAction: didTapBackwardButton,
                    forwardButtonAction: didTapForwardButton,
                    playButtonAction: didTapPlayButton
                )
                .padding(.bottom, 30)
                .background(Color.clear)
            }
        )
        
    }
}

private extension TabBarView {
    
    struct TabBarButton: View, Equatable {
        
        let tab: Tab
        let title: String
        let action: () -> Void
        let isSelected: Bool
        
        
        static func == (
            lhs: TabBarView.TabBarButton,
            rhs: TabBarView.TabBarButton
        ) -> Bool {
            lhs.tab == rhs.tab &&
            lhs.isSelected == rhs.isSelected
        }
        
        var body: some View {
            VStack {
                Button(action: action) {
                    Text(title)
                        .font(.system(size: 20, weight: .medium))
                        .opacity(isSelected ? 1 : 0.2)
                        .foregroundColor(.white)
                }
                Circle()
                    .fill(.eclipse6)
                    .frame(width: 15, height: 15)
                    .scaleEffect(isSelected ? 1 : 0.5)
                    .opacity(isSelected ? 1 : 0)
                    .animation(
                        .easeInOut(duration: 0.3),
                        value: isSelected
                    )
            }
        }
        
    }
}

enum Tab: String, CaseIterable {
    case popular
    case favorites
    case allStations
    
    var title: String {
        self.rawValue.capitalized
    }
}
