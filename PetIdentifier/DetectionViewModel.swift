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
    
    func reset() {
        DispatchQueue.main.async {
            self.image = nil
            self.breed = nil
            self.accuracy = nil
        }
    }
    
    func classifyImage() {
    }
}
