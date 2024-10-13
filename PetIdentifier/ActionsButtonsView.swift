//
//  ActionsButtonsView.swift
//  PetIdentifier
//
//  Created by nate on 10/13/24.
//

import SwiftUI

struct ActionsButtonsView: View {
    @Binding var image: UIImage?
    var classifyImage: () -> Void
    var reset: () -> Void
    
    var body: some View {
        VStack(spacing: 10) {
            if image != nil {
                Button(action: classifyImage) {
                    Text("Detect Breed")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Button(action: reset) {
                    Text("Reset")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
    }
}


#Preview {
  ActionsButtonsView(
    image: .constant(UIImage(systemName: "photo")),
    classifyImage: {},
    reset: {}
  )
}
