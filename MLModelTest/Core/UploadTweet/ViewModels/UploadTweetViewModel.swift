//
//  UploadTweetViewModel.swift
//  MLModelTest
//
//  Created by Tihara Jayawickrama on 2024-01-21.
//

import Foundation
import UIKit

class UploadTweetViewModel: ObservableObject{
    @Published var didUploadTweet = false
    let service = TweetService()
    
    func uploadTweet(withCaption caption: String, uploadedImage: UIImage?){
        service.uploadTweet(caption: caption, image: uploadedImage) { success in
            if success {
                self.didUploadTweet = true
            }
            else{
                
            }
        }
    }
}
