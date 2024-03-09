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
    @Published var textAnalysis : TextAnalysis = TextAnalysis()
    
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
            self?.passTextTweet()
        }
    }
    
    func reloadTweets(){
        fetchTweets()
    }
    
    func passImageUrl() {
        if let imageUrlString = tweet.imageUrl, !imageUrlString.isEmpty, let url = URL(string: imageUrlString) {
            imageAnalysis.classificationCompletion = { result in
                self.tweet.isSpam = result
            }
            imageAnalysis.loadImageFromURL(url: url)
            
        }
    }
    
    func passTextTweet(){
        textAnalysis.classifyText(tweet.caption)
        DispatchQueue.main.async{
            self.tweet.isSpam = self.textAnalysis.classificationResult
            print("TEXT RESULT for \(self.tweet.caption) -> \(self.tweet.isSpam)")
        }
    }
}
