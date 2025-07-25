//
//  PopularCell.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 30.08.2024.
//
//TODO: прокинуть локализацию")
import SwiftUI

struct TabBarCell: View {
    
    private enum Drawing {
        static let titleSize: CGFloat = 30
        static let playButtonSize = CGSize(width: 20, height: 20)
        static let favoritesButtonSize = CGSize(width: 15, height: 12)
        static let hStackSpacing: CGFloat = 8
        static let textOpacitySelected: CGFloat = 1.0
        static let textOpacityUnselected: CGFloat = 0.2
        static let imageTopPadding: CGFloat = 10
        static let popularCellSize = CGSize(width: 129, height: 129)
        static let favoriteCellSize = CGSize(width: 183, height: 100)
        static let cellPadding: CGFloat = 8
        static let allStationCellSize = CGSize(width: 130, height: 131)
        static let favoriteTextFrame = CGSize(width: 140, height: 80)
        static let spacerMinLength: CGFloat = 50
        static let favoritesButtonFrame = CGSize(width: 61, height: 53)
        static let favoriteCellHorizontalPadding: CGFloat = 10
    }
    
    private let type: CellType
    private var station: LocalStation
    private let didTapCell: () -> Void
    private let didTapFavorites: () async -> Void
    private var isSelected: Bool
    private var isPlaying: Bool
    private var isFavorite: Bool
    
    init(_ station: LocalStation,
         isSelected: Bool,
         didTapPlayButton: @escaping () -> Void,
         didTapFavorites: @escaping () async -> Void,
         isPlaying: Bool,
         type: CellType,
         isFavorite: Bool) {
        self.station = station
        self.isSelected = isSelected
        self.didTapCell = didTapPlayButton
        self.didTapFavorites = didTapFavorites
        self.isPlaying = isPlaying
        self.type = type
        self.isFavorite = isFavorite
    }
    
    var body: some View {
        CellBackground(isSelected: isSelected) {
            
            switch type {
            case .popular:
                VStack {
                    HStack(spacing: Drawing.hStackSpacing) {
                        Image(isSelected ? .playButton : .empty)
                            .resizable()
                            .frame(width: Drawing.playButtonSize.width, height: Drawing.playButtonSize.height)
                            .padding(.top, 4)
                        
                        Text("Votes \(Int(station.votes))")
                            .foregroundStyle(.white)
                            .applyFonts(for: .votes)
                            .opacity(isSelected ? Drawing.textOpacitySelected : Drawing.textOpacityUnselected)
                        
                        Button(asyncAction: didTapFavorites) {
                            Image(isFavorite ? .favoriteButtonFill : .favoriteButtonEmpty)
                                .resizable()
                                .frame(width: Drawing.favoritesButtonSize.width, height: Drawing.favoritesButtonSize.height)
                        }
                    }
                    
                    Text(station.name)
                        .applyFonts(for: .cellHeader)
                        .foregroundStyle(.white)
                        .opacity(isSelected ? Drawing.textOpacitySelected : Drawing.textOpacityUnselected)
                    
                    Text(station.tags)
                        .applyFonts(for: .regular)
                        .lineLimit(1)
                        .foregroundStyle(.white)
                        .opacity(isSelected ? Drawing.textOpacitySelected : Drawing.textOpacityUnselected)
                    
                    SingleWaveView(isSelected: isSelected, isPlaying: isPlaying)
                        .padding(.top, Drawing.imageTopPadding)
                }
                .frame(width: Drawing.popularCellSize.width, height: Drawing.popularCellSize.height)
                .padding(.all, Drawing.cellPadding)
                
            case .favorites:
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(station.name)
                            .applyFonts(for: .subtitle)
                            .foregroundStyle(.white)
                        
                        Text(station.tags)
                            .applyFonts(for: .regular)
                            .foregroundStyle(.white)

                        SingleWaveView(isSelected: isSelected, isPlaying: isPlaying)
                            .padding(.top, Drawing.imageTopPadding)
                    }
                    .frame(
                        width: Drawing.favoriteTextFrame.width,
                        height: Drawing.favoriteTextFrame.height
                    )
                    
                    Spacer(minLength: Drawing.spacerMinLength)
                    
                    Button(asyncAction: didTapFavorites) {
                        Image(.favoritesButtonFill)
                            .resizable()
                            .frame(width: Drawing.favoritesButtonFrame.width, height: Drawing.favoritesButtonFrame.height)
                    }
                }
                .frame(width: Drawing.favoriteCellSize.width, height: Drawing.favoriteCellSize.height)
                .padding(.horizontal, Drawing.favoriteCellHorizontalPadding)
            
            case .allStations:
               
                HStack {
                    VStack {
                        Text(station.name)
                            .applyFonts(for: .cellHeader)
                            .foregroundStyle(.white)
                            .opacity(isSelected ? Drawing.textOpacitySelected : Drawing.textOpacityUnselected)
                        Spacer()
                        Text(station.tags)
                            .applyFonts(for: .regular)
                            .foregroundStyle(.white)
                            .opacity(isSelected ? Drawing.textOpacitySelected : Drawing.textOpacityUnselected)
                        Spacer()
                        Text(isSelected ? "Playing now" : "")
                            .applyFonts(for: .regularBold)
                            .foregroundStyle(.eclipseMulberry)
                        
                    }
                    .frame(
                        width: Drawing.favoriteTextFrame.width,
                        height: Drawing.favoriteTextFrame.height
                    )
                    
                    Spacer(minLength: Drawing.spacerMinLength)
                    
                    VStack {
                        HStack(spacing: 6) {
                            Text("Votes \(Int(station.votes))")
                                .foregroundStyle(.white)
                                .lineLimit(1)
                                .truncationMode(.tail)
                                .minimumScaleFactor(0.5)
                                .applyFonts(for: .votes)
                                .opacity(isSelected ?
                                         Drawing.textOpacitySelected :
                                            Drawing.textOpacityUnselected)
                                .frame(width: 68, alignment: .leading)
                            
                            
                            Button(asyncAction: didTapFavorites) {
                                Image(isFavorite ? .favoriteButtonFill : .favoriteButtonEmpty)
                                    .resizable()
                                    .frame(
                                        width: Drawing.favoritesButtonSize.width,
                                        height: Drawing.favoritesButtonSize.height
                                    )
                            }
                        }
                        SingleWaveView(isSelected: isSelected, isPlaying: isPlaying)
                            .padding(.top, Drawing.imageTopPadding)
                    }
                }
                .frame(
                    width: Drawing.allStationCellSize.width,
                    height: Drawing.allStationCellSize.height
                )
            }
        }
        .onTapGesture {
            didTapCell()
        }
    }
}

extension TabBarCell {
    enum CellType {
        case popular
        case favorites
        case allStations
    }
}

#Preview {
    TabBarBackground {
        TabBarCell(
            LocalStation(
                stationuuid: "123456",
                name: "Test Station",
                tags: "Rock, Pop, dsadsa, dsadsa",
                url: "https://example.com/stream",
                urlResolved: nil,
                homepage: "https://example.com",
                favicon: nil,
                country: "USA",
                language: "English",
                votes: 100,
                isFavorite: false
            ),
            isSelected: true,
            didTapPlayButton: {},
            didTapFavorites: {},
            isPlaying: false,
            type: .allStations,
            isFavorite: false
        )
    }
}
