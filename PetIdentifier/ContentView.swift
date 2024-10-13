//
//  ContentView.swift
//  PetIdentifier
//
//  Created by nate on 10/13/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Dog / Cat Identifier")
                    .font(.title)
                    .padding()
                NavigationLink {
                    DetectionView()
                } label: {
                    Text("Start Identifying")
                        .font(.headline)
                }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
