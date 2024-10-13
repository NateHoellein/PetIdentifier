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
    
    private let classifier = PetBreeds()
    
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
                        self?.accuracy = String(format: "%.2f%%", (confidence ?? 0) * 100.0)
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
