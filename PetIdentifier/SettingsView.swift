//
//  SettingsView.swift
//  PetIdentifier
//
//  Created by nate on 10/13/24.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var viewModel: DetectionViewModel
    @State private var modelDescription: String = "V1 Feature extractor scales input images to 299 x 299 and yeilds a feature embedding size of 2048"
    
    var body: some View {
        VStack {
            Text("Choose a model")
                .font(.title)
            Divider()
            Picker("Model Type", selection: $viewModel.classifierModelOption) {
                Text("V1 Model").tag(0)
                Text("V2 Model").tag(1)
            }
            .pickerStyle(.segmented)
            .onChange(of: viewModel.classifierModelOption) { (oldValue, newValue) in
                print("Old: \(oldValue) New: \(newValue)")
                if newValue == 0 {
                    viewModel.switchClassifierModel(PetBreedsModels.v1)
                    modelDescription = "V1 Feature extractor scales input images to 299 x 299 and yeilds a feature embedding size of 2048"
                }
                if newValue == 1 {
                    viewModel.switchClassifierModel(PetBreedsModels.v2)
                    modelDescription = "V2 Feature extractor scales input images to 360 x 360 and yeilds a feature embedding size of 768"
                }
            }
            .padding()
            Text(modelDescription)
                .font(.subheadline)
            Divider()
            Text("Accuracy Percentage \(viewModel.accuracyPercentage * 100, specifier: "%.2f")%")
            Slider(value: $viewModel.accuracyPercentage, in: 0...1)
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

#Preview {
    SettingsView(viewModel: DetectionViewModel())
}
