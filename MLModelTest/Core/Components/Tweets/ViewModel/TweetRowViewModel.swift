//
//  TweetRowViewModel.swift
//  MLModelTest
//
//  Created by Tihara Jayawickrama on 2024-01-22.
//

import Foundation
import Firebase

class TweetRowViewModel: ObservableObject {
    @Published var tweet: Tweet
    @Published var tweets: [Tweet] = []
    @Published var imageAnalysis : ImageAnalysis = ImageAnalysis()
    @Published var textAnalysis : TextAnalysis = TextAnalysis()
    
    private let service = TweetService()
    private var listener: ListenerRegistration?
    
    init(tweet: Tweet){
        self.tweet = tweet
    }
    
    private func listenForTweetChanges() {
        listener = Firestore.firestore().collection("tweets").document(tweet.id ?? "32324").addSnapshotListener { [weak self] snapshot, error in
            guard let snapshot = snapshot, snapshot.exists else {
                print("Error fetching tweet: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                 let updatedTweet = try snapshot.data(as: Tweet.self)
                    self?.tweet = updatedTweet
                    self?.passImageUrl()
                    self?.passTextTweet()
                
            } catch {
                print("Error decoding tweet: \(error.localizedDescription)")
            }
        }
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
                if result == "Spam"{
                    self.tweet.isImageSpam = true
                }
            }
            imageAnalysis.loadImageFromURL(url: url)
            
        }
    }
    
    func passTextTweet(){
        textAnalysis.classifyText(tweet.caption ?? " ")
        DispatchQueue.main.async{
            if self.textAnalysis.classificationResult == "spam"{
                self.tweet.isTextSpam = true
            }
            self.tweet.isSpam = self.textAnalysis.classificationResult
        }
    }
}
