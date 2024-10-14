//
//  DetectionViewModel.swift
//  PetIdentifier
//
//  Created by nate on 10/13/24.
//

import SwiftUI

class DetectionViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var breed: String?
    @Published var accuracy: String?
    @Published var accuracyPercentage: Double = 0.8
    @Published var classifierModel: PetBreedsModels = .v1
    @Published var classifierModelOption: Int = 0
    
    private let classifier = PetBreeds()
    
    func switchClassifierModel(_ model: PetBreedsModels) {
        classifierModel = classifier.setClassifierModel(to: model)
        switch classifierModel {
        case .v1: classifierModelOption = 0
        case .v2: classifierModelOption = 1
        }
    }
    
    func reset() {
        DispatchQueue.main.async {
            self.image = nil
            self.breed = nil
            self.accuracy = nil
        }
    }
    
    func classifyImage() {
        if let image = self.image {
            let resizedImage = resizeImage(image)
            DispatchQueue.global(qos: .userInteractive).async {
                self.classifier.classify(image: resizedImage ?? image) { [weak self] breed, confidence in
                    DispatchQueue.main.async {
                        self?.breed = breed ?? "Unknown"
                        let c = Double(confidence ?? 0)
                        if c < self!.accuracyPercentage {
                            self?.accuracy = "Classification confidence of \(String(format: "%.2f", c)) is below the set threshold of \(String(format: "%.2f", self!.accuracyPercentage))."
                        } else {
                            self?.accuracy = String(format: "%.2f%%", (confidence ?? 0) * 100.0)
                        }
                    }
                }
            }
        }
    }
    
    private func resizeImage(_ image: UIImage) -> UIImage? {
        let size = CGSize(width: 224, height: 224)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
