//
//  SettingsButtonView.swift
//  PetIdentifier
//
//  Created by nate on 10/13/24.
//

import SwiftUI

struct SettingsButtonView: View {
    @ObservedObject var viewModel: DetectionViewModel
    @Binding var image: UIImage?
    @State var settingsModal:Bool = false
    
    var body: some View {
        if image == nil {
            Button("Settings") {
                settingsModal = true
            }
            .sheet(isPresented: $settingsModal, content: {
                SettingsView(viewModel: viewModel)
            })
        }
    }    
}
