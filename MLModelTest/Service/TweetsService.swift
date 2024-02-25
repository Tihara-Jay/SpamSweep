//
//  TweetsService.swift
//  MLModelTest
//
//  Created by Tihara Jayawickrama on 2024-01-21.
//

import Firebase

struct TweetService{
    
    func uploadTweet(caption: String, image: UIImage?, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        if let image = image {
            UserImageUploader.uploadImage(image: image) { imageUrl in
                
                let imageUrl = imageUrl
                
                let data = ["uid": uid,
                            "caption": caption,
                            "likes": 0,
                            "timestamp": Timestamp(date: Date()),
                            "imageUrl": imageUrl] as [String : Any]
                
                Firestore.firestore().collection("tweets")
                    .addDocument(data: data) { error in
                        if let error = error {
                            print("DEBUG: Failed to upload tweet with error: \(error.localizedDescription)")
                            completion(false)
                            return
                        }
                        completion(true)
                    }
            }
        } else {
            let data = ["uid": uid,
                        "caption": caption,
                        "likes": 0,
                        "timestamp": Timestamp(date: Date())] as [String : Any]
            
            Firestore.firestore().collection("tweets")
                .addDocument(data: data) { error in
                    if let error = error {
                        print("DEBUG: Failed to upload tweet with error: \(error.localizedDescription)")
                        completion(false)
                        return
                    }
                    completion(true)
                }
        }
    }
    
    func fetchTweets(completion: @escaping([Tweet]) -> Void){
        Firestore.firestore().collection("tweets")
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            let tweets = documents.compactMap({ try? $0.data(as: Tweet.self)})
            completion(tweets)
                
        }
    }
    
    func fetchTweets(forUid uid: String, completion: @escaping([Tweet]) -> Void){
        Firestore.firestore().collection("tweets")
            .whereField("uid", isEqualTo: uid)
            .getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            let tweets = documents.compactMap({ try? $0.data(as: Tweet.self)})
                completion(tweets.sorted(by: {$0.timestamp.dateValue() > $1.timestamp.dateValue()}))
                
        }
    }
    
    func likeTweet(_ tweet: Tweet, completion: @escaping() -> Void){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        
        Firestore.firestore().collection("tweets").document(tweetId)
            .updateData(["likes": tweet.likes + 1]) { _ in
                userLikesRef.document(tweetId).setData([:]) { _ in
                    completion()
                }
            }
    }
}
