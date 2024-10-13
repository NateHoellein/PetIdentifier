//
//  ImageDisplayView.swift
//  PetIdentifier
//
//  Created by nate on 10/13/24.
//

import SwiftUI

struct ImageDisplayView: View {
    @Binding var image: UIImage?
    @Binding var showSourceTypeActionView: Bool
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                  .resizable()
                  .scaledToFit()
                  .frame(maxWidth: .infinity, maxHeight: 300)
                  .cornerRadius(10)
                  .shadow(radius: 10)
                  .onTapGesture {
                      self.showSourceTypeActionView = true
                  }
                  .padding()
            } else {
                VStack(spacing: 10) {
                  Image(systemName: "photo.on.rectangle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)
                  Text("Tap to Select an Image")
                    .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, maxHeight: 300)
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
                .shadow(radius: 10)
                .onTapGesture {
                    self.showSourceTypeActionView = true
                }
                .padding()
            }
        }
    }
}

#Preview {
    ImageDisplayView(image: .constant(nil), showSourceTypeActionView: .constant(false))
}
