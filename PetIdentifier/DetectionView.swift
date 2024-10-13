//
//  DetectionView.swift
//  PetIdentifier
//
//  Created by nate on 10/13/24.
//

import SwiftUI

struct DetectionView: View {
    @StateObject private var viewModel = DetectionViewModel()
    @State var isShowingImagePicker: Bool = false
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State var showSourceTypeActionSheet: Bool = false
    
    
    var body: some View {
        VStack(spacing: 20) {
            ImageDisplayView(image: $viewModel.image,
                             showSourceTypeActionView: $showSourceTypeActionSheet)
            
            if let breed = viewModel.breed, let accuracy = viewModel.accuracy {
                BreedResultsView(breed: breed,
                                 accuracy: accuracy)
            }
            ActionsButtonsView(image: $viewModel.image, classifyImage:
                                viewModel.classifyImage,
                               reset: viewModel.reset)
        }
        .navigationTitle("Dog / Cat Detection")
        .actionSheet(isPresented: $showSourceTypeActionSheet) {
            ActionSheet(title: Text("Find an Image using:"), message: nil, buttons: [
                .default(Text("Camera")) {
                    self.sourceType = .camera
                    self.isShowingImagePicker = true
                },
                .default(Text("Photo Library")) {
                    self.sourceType = .photoLibrary
                    self.isShowingImagePicker = true
                },
                .cancel()
            ])
        }
        .sheet(isPresented: $isShowingImagePicker) {
            ImagePicker(image: self.$viewModel.image, sourceType: self.$sourceType)
        }
    }
}

#Preview {
    DetectionView()
}
