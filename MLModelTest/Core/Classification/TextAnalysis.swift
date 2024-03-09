//
//  TextAnalysis.swift
//  MLModelTest
//
//  Created by Tihara Jayawickrama on 2024-03-09.
//

import Foundation
import CoreML
import NaturalLanguage

class TextAnalysis : ObservableObject {
    
    @Published var classificationResult : String = ""
    
    func classifyText(_ text: String) {
        guard !text.isEmpty else {
            // Handle empty input gracefully
            self.classificationResult = "Input text is empty."
            return
        }
        
        // Load your Core ML model
        guard let model = try? SpamTextClassification(configuration: MLModelConfiguration()) else {
            self.classificationResult = "Failed to load model."
            return
        }
        
        // Create a text classifier instance
        guard let textClassifier = try? NLModel(mlModel: model.model) else {
            self.classificationResult = "Failed to create text classifier."
            return
        }
        
        // Perform classification
        if let classification = textClassifier.predictedLabel(for: text) {
            self.classificationResult = classification
           
        } else {
            self.classificationResult = "Classification failed."
        }
    }
    
}
