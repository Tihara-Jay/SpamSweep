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
        }
    }
    
    func reloadTweets(){
        fetchTweets()
    }
}
