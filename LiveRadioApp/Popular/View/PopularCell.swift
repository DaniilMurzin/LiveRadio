//
//  PopularCell.swift
//  LiveRadioApp
//
//  Created by Шаповалов Илья on 30.08.2024.
//

import SwiftUI

struct PopularCell: View {
    private enum Drawing {
        static let titleSize: CGFloat = 30
        static let playButton = CGSize(width: 37, height: 37)
        static let favoritesButton = CGSize(width: 15, height: 12)
        static let votesText = CGSize(width: 50, height: 12)
        static let favoriteButtonPadding: CGFloat = -8
    }
    
    var station: Station
    
    init(_ station: Station) {
        self.station = station }
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Button(action: {})
                {
                    Image(.playButton)
                        .foregroundStyle(Color.red)
                        .frame(width: Drawing.playButton.width, height: Drawing.playButton.height)
                }
        //TODO: прокинуть локализацию")
                Text("Votes \(Int(station.votes ?? 100))")
                    .foregroundStyle(.white)
                    .applyFonts(for: .votes)
                    .frame(width: Drawing.votesText.width, height: Drawing.votesText.height)
                    

                Button(action: {}) {
                    Image(.favoriteButton)
                        .frame(width: Drawing.favoritesButton.width, height: Drawing.favoritesButton.height)
                }
                .padding(.leading, Drawing.favoriteButtonPadding)
            }
            
            Text(station.name ?? "POP")
                .applyFonts(for: .subtitle)
                .foregroundStyle(Color.white)
            Text(station.tags ?? "Radio Live")
                .applyFonts(for: .regular)
            Image(.cell)
                .padding(.top)
        }
        .frame(width: 119, height: 119)
        .padding()
        .background(
            Color.white.opacity(0.3),
            in: RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 2)
        )
    }
    
}

#Preview {
    ZStack {
        Color.mainBg
        PopularCell(Station(name: "Test",tags: "POPULAR", votes: 4 ))
    }
}
