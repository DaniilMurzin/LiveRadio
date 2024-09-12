//
//  PopularView.swift
//  LiveRadioApp
//
//  Created by Шаповалов Илья on 30.08.2024.
//

import SwiftUI

struct PopularView: View {
    private enum Drawing {
        static let titleSize: CGFloat = 30
    }
    
    private let columns = [
        GridItem(.flexible(), spacing: 5),
        GridItem(.flexible(), spacing: 5)
    ]

    let title: String
    let stations: [Station]
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color(.mainBg).ignoresSafeArea()
            LazyVStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: Drawing.titleSize))
                    .foregroundStyle(Color.white)
                    .padding()
                
                LazyVGrid(columns: columns) {
                    ForEach(stations, id:\.self) { station in
                        PopularCell(station)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    PopularView(
        title: "Popular",
        stations: Station.preview
    )
}
