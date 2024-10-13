//
//  PetBreeds.swift
//  PetIdentifier
//
//  Created by nate on 10/13/24.
//

import Vision
import CoreML
import SwiftUI

class PetBreeds {
    private let model: VNCoreMLModel
    
    init() {
        let configuration = MLModelConfiguration()
        guard let mlModel = try? PetBreeds_v1(configuration: configuration).model else {
            fatalError("Failed to load model")
        }
        self.model = try! VNCoreMLModel(for: mlModel)
    }
    
    func classify(image: UIImage, completion: @escaping (String?, Float?) -> Void) {
        
        guard let cgImage = CIImage(image: image) else {
            completion(nil, nil)
            return
        }
        
        let request = VNCoreMLRequest(model: model) { request, error in
            if let error = error {
                print("Error during classification: \(error.localizedDescription)")
                completion(nil, nil)
                return
            }
            
            
            guard let results = request.results as? [VNClassificationObservation] else {
                print("No results found :( ")
                completion(nil, nil)
                return
            }
            
            let topResult = results.max(by: { a, b in a.confidence < b.confidence })
            guard let bestResult = topResult else {
                print("No top result found")
                completion(nil, nil)
                return
            }
            
            completion(bestResult.identifier, bestResult.confidence)
        }
        
        let handler = VNImageRequestHandler(ciImage: cgImage)
        
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try handler.perform([request])
            } catch {
                print("Failed to perform classification: \(error.localizedDescription)")
                completion(nil, nil)
            }
        }
    }
}

