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
    }
    
    let station: Station
    
    init(_ station: Station) { self.station = station }
    
    var body: some View {
        VStack(alignment: .center) {
            Text(station.title)
                .font(.system(size: Drawing.titleSize))
                .foregroundStyle(Color.white)
                .padding()
            
        }
        .background(
            Color.white.opacity(0.3),
            in: RoundedRectangle(cornerRadius: 15).stroke()
        )
    }
}

#Preview {
    ZStack {
        Color.mainBg
        PopularCell(.preview[0])
    }
}
