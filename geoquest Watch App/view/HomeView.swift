//
//  HomeView.swift
//  geoquest Watch App
//
//  Created by robert theo on 24/05/24.
//

import SwiftUI

struct HomeView: View {
    @State private var points = 0

    var body: some View {
        NavigationStack {
            VStack {
                Text("Points: \(points)")
                    .font(.largeTitle)
                    .padding()

                NavigationLink(destination: SampleMap(points: $points)) {
                    Text("Play")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
