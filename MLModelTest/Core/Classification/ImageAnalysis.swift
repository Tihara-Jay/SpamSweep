//
//  ImageAnalysis.swift
//  MLModelTest
//
//  Created by Tihara Jayawickrama on 2024-03-02.
//

import Foundation
import CoreML
import  SwiftUI
import Vision

class  ImageAnalysis : ObservableObject{
    
    @Published var identifier : String = ""
    @Published var selectedImage : UIImage?
    @Published var result : String = ""
    var classificationCompletion : ((String) -> Void)??
    
    lazy var classificationRequest : VNCoreMLRequest = {
        //print("inside the classification request")
        do{
            
            let config = MLModelConfiguration()
            config.computeUnits = .all
            let model = try VNCoreMLModel(for: SpamImageClassification(configuration: config).model)
            
            let request = VNCoreMLRequest(model: model) {[weak self] response, error in
                
                guard let self = self else{return}
                self.checkResults(response: response)
                
            }
            #if targetEnvironment(simulator)
            request.usesCPUOnly = true
            #endif
            
            return request
            
        }
        catch
        {
            fatalError("Unable to load the model")
        }
        
    }()
    
    func runMLPipeline(url:URL)  {
        //print("Inside ML pipeline")
        DispatchQueue.global(qos: .userInitiated).async {
             self.loadImageFromURL(url: url)
            guard let image = self.selectedImage else {
                //print("loading selected image failed")
                return
            }
            if let convertedImage = self.preprocessImage(image: image){
                guard let ciImage = CIImage(image: convertedImage) else {return}
                //guard let ciImage = CIImage(image: image) else {return}
                
                let handler = VNImageRequestHandler(ciImage: ciImage)
                
                do{
                    try handler.perform([self.classificationRequest])
                    
                }catch{
                    print("Unable to perform the ML task")
                    
                }
            }
        }
    }
    
    func loadImageFromURL(url: URL)  {
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                //print("loading image from URL started")
                let imageData = try Data(contentsOf: url)
                if let image = UIImage(data: imageData) {
                    if let tweetImage = self.preprocessImage(image: image) {
                        //DispatchQueue.main.async {
                            self.selectedImage = tweetImage
                            self.runMLPipeline(url: url) // Call runMLPipeline after setting selectedImage
                        //}
                    } else {
                        print("TEST ERROR")
                    }
                } else {
                    print("Failed to convert data to image")
                }
                //print("finished loading image")
            } catch {
                print("Error loading image from URL: \(error.localizedDescription)")
            }
        }
        //return nil
    }

    
    func preprocessImage(image: UIImage) -> UIImage? {
            let newSize = CGSize(width: 299, height: 299)

            UIGraphicsBeginImageContextWithOptions(newSize, true, 1.0)
            defer {
                UIGraphicsEndImageContext()
            }

            guard let context = UIGraphicsGetCurrentContext() else {
                return nil
            }

            // Flip the coordinate system to match UIKit's
            context.translateBy(x: 0, y: newSize.height)
            context.scaleBy(x: 1.0, y: -1.0)

            // Draw the image in the new size
            context.draw(image.cgImage!, in: CGRect(origin: .zero, size: newSize))

            return UIGraphicsGetImageFromCurrentImageContext()
        }

    
    func checkResults(response : VNRequest){
        
        DispatchQueue.main.async {
            guard let  result = response.results   else {return}
            //print("response: \(response)")
            //print("result \(result)")
                      
           let classification = result as! [VNClassificationObservation]
           let description = classification.prefix(5).filter({
                $0.confidence > 0.5
            })
            
            if let identifier = description.first?.identifier{
                self.identifier = identifier
                //print("RESULT: \(identifier)")
                if let completion = self.classificationCompletion {
                    completion?(identifier)
                }
            }
        }
    }
}

