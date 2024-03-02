//
//  Tweet.swift
//  MLModelTest
//
//  Created by Tihara Jayawickrama on 2024-01-21.
//

import FirebaseFirestoreSwift
import Firebase

struct Tweet: Identifiable, Decodable {
    @DocumentID var id: String?
    let caption: String
    let timestamp : Timestamp
    let uid: String
    var likes: Int
    var imageUrl: String?
    var user: User?
    var didLike: Bool? = false
    
    var isSpam: String?
}
