//
//  BreedResultsView.swift
//  PetIdentifier
//
//  Created by nate on 10/13/24.
//

import SwiftUI

struct BreedResultsView: View {
    let breed: String
    let accuracy: String
    
    var body: some View {
        VStack(spacing: 5) {
            Text("Breed: \(breed)")
                .font(.title2)
                .padding(.bottom)
            Text("Accuracy: \(accuracy)")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

#Preview {
    BreedResultsView(breed: "Labrador Retriever", accuracy: "90%")
}
