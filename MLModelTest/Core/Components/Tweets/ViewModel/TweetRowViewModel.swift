//
//  TweetRowViewModel.swift
//  MLModelTest
//
//  Created by Tihara Jayawickrama on 2024-01-22.
//

import Foundation

class TweetRowViewModel: ObservableObject {
    @Published var tweet: Tweet
    @Published var tweets: [Tweet] = []
    @Published var imageAnalysis : ImageAnalysis = ImageAnalysis()
    
    private let service = TweetService()
    
    
    init(tweet: Tweet){
        self.tweet = tweet
    }
    
    func likeTweet(){
        service.likeTweet(tweet){
            self.tweet.didLike = true
        }
    }
    
    func fetchTweets(){
        service.fetchTweets {
            [weak self] tweets in
            self?.tweets = tweets
            self?.passImageUrl()
        }
    }
    
    func reloadTweets(){
        fetchTweets()
    }
    
    func passImageUrl() {
        if ( !((tweet.imageUrl?.isEmpty) == nil) ){
           // print("Image URL: \(tweet.imageUrl)")
//            guard let imageUrlString = tweet.imageUrl, !imageUrlString.isEmpty, let url = URL(string: imageUrlString) else {
//                       print("pass image URL() failed")
//                       return
                  }
            if let imageUrlString = tweet.imageUrl, !imageUrlString.isEmpty, let url = URL(string: imageUrlString) {
                       
                       imageAnalysis.classificationCompletion = { result in
                           self.tweet.isSpam = result
                       }
            imageAnalysis.loadImageFromURL(url: url)
          
        }
    }
}
