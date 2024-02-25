//
//  ImageUploader.swift
//  MLModelTest
//
//  Created by Tihara Jayawickrama on 2024-01-21.
//
import Firebase
import FirebaseStorage
import UIKit

struct ImageUploader{
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void){
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        let fileName = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_image/\(fileName)")
        
        ref.putData(imageData, metadata: nil) { _, error in
            if let error = error{
                print("DEBUG: Failed to upload image. Error: \(error.localizedDescription)")
                return
            }
            ref.downloadURL {imageUrl, _ in
                guard let imageUrl = imageUrl?.absoluteString else { return}
                completion(imageUrl)
            }
        }
    }
    
}

struct UserImageUploader{
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void){
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        let fileName = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/uploaded_images/\(fileName)")
        
        ref.putData(imageData, metadata: nil) { _, error in
            if let error = error{
                print("DEBUG: Failed to upload image. Error: \(error.localizedDescription)")
                return
            }
            ref.downloadURL {imageUrl, _ in
                guard let imageUrl = imageUrl?.absoluteString else { return}
                completion(imageUrl)
            }
        }
    }
}
