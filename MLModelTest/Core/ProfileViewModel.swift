//
//  ProfileViewModel.swift
//  MLModelTest
//
//  Created by Tihara Jayawickrama on 2024-01-21.
//

import Foundation

class ProfileViewModel: ObservableObject{
    @Published var tweets = [Tweet]()
    private let service = TweetService()
    let user: User
    
    init(user: User){
        self.user = user
        self.fetchUserTweets()
    }
    
    func fetchUserTweets(){
        guard let uid = user.id else {return}
        service.fetchTweets(forUid: uid) { tweets in
            self.tweets = tweets
            
            for i in 0 ..< tweets.count {
                self.tweets[i].user = self.user
            }
        }
    }
    
}
