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
        static let playButton = CGSize(width: 20, height: 20)
        static let favoritesButton = CGSize(width: 15, height: 12)
        static let hStackSpacing: CGFloat = 8
        static let textOpacitySelected: CGFloat = 1.0
        static let textOpacityUnselected: CGFloat = 0.2
        static let imageTopPadding: CGFloat = 10
        static let cellWidth: CGFloat = 129
        static let cellHeight: CGFloat = 129
        static let cellPadding: CGFloat = 8
    }
    
    private let type: CellType
    private var station: Station
    private let didTapCell: () -> Void
    private let didTapFavorites: () -> Void
    private var isSelected: Bool
    private var isPlaying: Bool
//    private var didChangeAmplitude: CGFloat
    
    init(_ station: Station,
         isSelected: Bool,
         didTapPlayButton: @escaping () -> Void,
         didTapFavorites: @escaping () -> Void,
         isPlaying: Bool,
         type: CellType) {
        self.station = station
        self.isSelected = isSelected
        self.didTapCell = didTapPlayButton
        self.didTapFavorites = didTapFavorites
        self.isPlaying = isPlaying
        self.type = type
    }
    
    var body: some View {
        CellBackground(isSelected: isSelected) {
            switch type {
            case .popular:
                VStack {
                    HStack(spacing: Drawing.hStackSpacing) {
                        Image(isSelected ? .playButton : .empty)
                            .resizable()
                            .frame(width: Drawing.playButton.width, height: Drawing.playButton.height)
                            .padding(.top, 4)
                        
                        Text("Votes \(Int(station.votes))")
                            .foregroundStyle(.white)
                            .applyFonts(for: .votes)
                            .opacity(isSelected ? Drawing.textOpacitySelected : Drawing.textOpacityUnselected)
                        
                        Button(action: didTapFavorites) {
                            Image(.favoriteButtonEmpty)
                                .resizable()
                                .frame(width: Drawing.favoritesButton.width, height: Drawing.favoritesButton.height)
                        }
                    }
                    Text(station.name)
                        .applyFonts(for: .subtitle)
                        .foregroundStyle(Color.white)
                        .opacity(isSelected ? Drawing.textOpacitySelected : Drawing.textOpacityUnselected)
                    
                    Text(station.tags)
                        .applyFonts(for: .regular)
                        .foregroundStyle(Color.white)
                        .opacity(isSelected ? Drawing.textOpacitySelected : Drawing.textOpacityUnselected)
                    
                    SingleWaveView(isSelected: isSelected, isPlaying: isPlaying/*, amplitude: didChangeAmplitude*/ )
                        .padding(.top, Drawing.imageTopPadding)
                }
                .frame(width: Drawing.cellWidth, height: Drawing.cellHeight)
                .padding(.all, Drawing.cellPadding)
                
            case .favorites:
                HStack {
                    VStack(spacing: Drawing.hStackSpacing) {
                        Text(station.name)
                            .applyFonts(for: .subtitle)
                            .foregroundStyle(Color.white)
                            .opacity(isSelected ? Drawing.textOpacitySelected : Drawing.textOpacityUnselected)
                   
                        Text(station.tags)
                            .applyFonts(for: .regular)
                            .foregroundStyle(Color.white)
                            .opacity(isSelected ? Drawing.textOpacitySelected : Drawing.textOpacityUnselected)
                        
                        
                        SingleWaveView(isSelected: isSelected, isPlaying: isPlaying/*, amplitude: didChangeAmplitude*/ )
                            .padding(.top, Drawing.imageTopPadding)
                        
                    }
                    Spacer()
                    Button(action: didTapFavorites) {
                        Image(.favoriteButtonEmpty)
                            .resizable()
                            .frame(width: 61, height: 53)
                    }
                }
                .frame(width: 293, height: 123)
                .padding()
                
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
//        case allStations
    }
}

#Preview {
    TabBarCell(
        Station.mock,
        isSelected: false,
        didTapPlayButton: {},
        didTapFavorites: {},
        isPlaying: true,
        type: .favorites
        )
    .frame(width: 293, height: 123)
}
