//
//  User.swift
//  MLModelTest
//
//  Created by Tihara Jayawickrama on 2024-01-21.
//

import FirebaseFirestoreSwift

struct User: Identifiable, Decodable{
    @DocumentID var id: String?
    let username: String
    let fullname: String
    let profileImageUrl: String
    let email: String
    let uid: String
}
