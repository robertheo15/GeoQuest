//
//  SampleMap.swift
//  geoquestapp
//
//  Created by robert theo on 21/05/24.
//

import SwiftUI
import MapKit
import WatchConnectivity

struct SampleMap: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        Map(selection: $viewModel.selectedResult) {
            // Configure the map view here
        }
        .onAppear {
            viewModel.getDirections()
        }
    }
}

#Preview {
    SampleMap()
}
