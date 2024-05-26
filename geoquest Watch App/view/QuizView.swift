//
//  QuizView.swift
//  geoquest Watch App
//
//  Created by robert theo on 24/05/24.
//

import SwiftUI

struct QuizView: View {
    @Binding var isPresented: Bool
    @Binding var points: Int

    var body: some View {
        ScrollView {
            VStack(spacing: 5) {
                Text("What is the capital of France?")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 5)
                    .fixedSize(horizontal: false, vertical: true)
                
                Button(action: {
                    points += 1
                    isPresented = false
                }) {
                    Text("Paris")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                Button(action: {
                    isPresented = false
                }) {
                    Text("London")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                Button(action: {
                    isPresented = false
                }) {
                    Text("Berlin")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
    }
}

#Preview {
    QuizView(isPresented: .constant(true), points: .constant(1))
}
