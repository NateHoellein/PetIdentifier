//
//  PetBreeds.swift
//  PetIdentifier
//
//  Created by nate on 10/13/24.
//

import Vision
import CoreML
import SwiftUI

enum PetBreedsModels: String, CaseIterable, Identifiable {
    case v1 = "PetBreeds_v1"
    case v2 = "PetBreeds_v2"
    
    var id: Self { self }
    var description: String {
        switch self {
        case .v1: return "PetBreeds_v1"
        case .v2: return "PetBreeds_v2"
        }
    }
}

class PetBreeds {
    @State var activeModel: PetBreedsModels = .v1
    private var model: VNCoreMLModel
    
    init() {
        let configuration = MLModelConfiguration()
        guard let mlModelV1 = try? PetBreeds_v1(configuration: configuration).model else {
            fatalError("Failed to load model")
        }
        
        self.model = try! VNCoreMLModel(for: mlModelV1)
    }
    
    func setClassifierModel(to model: PetBreedsModels) -> PetBreedsModels {
        let configuration = MLModelConfiguration()
        switch model {
        case .v1:
            guard let mlModelV1 = try? PetBreeds_v1(configuration: configuration).model else {
                fatalError("Failed to load model")
            }
            activeModel = .v1
            self.model = try! VNCoreMLModel(for: mlModelV1)
            return .v1
            
        case .v2:
            guard let mlModelV2 = try? PetBreeds_v2(configuration: configuration).model else {
                fatalError("Failed to load model")
            }
            activeModel = .v2
            self.model = try! VNCoreMLModel(for: mlModelV2)
            return .v2
        }
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

