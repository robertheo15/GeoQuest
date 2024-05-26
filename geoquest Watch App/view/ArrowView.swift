//
//  ArrowView.swift
//  geoquest Watch App
//
//  Created by robert theo on 24/05/24.
//

import SwiftUI

struct ArrowView: View {
    let direction: Double
    
    var body: some View {
        ZStack {
            Image(systemName: "arrow.up")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .rotationEffect(.degrees(direction))
        }
    }
}
