//
//  AuthViewModel.swift
//  TwitterCloneFYP
//
//  Created by Tihara Jayawickrama on 2023-12-26.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject{
    @Published var userSession: FirebaseAuth.User? //storing the user session (will have a value if user is logged in, if not nil)
    @Published var didAuthenticateUser = false
    @Published var currentUser: User? 
    private var tempUserSession : FirebaseAuth.User?
    private let service = UserService()
    
    init(){
        self.userSession = Auth.auth().currentUser
        self.fetchUser()
    }
    
    func login(withEmail email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) {result, error in
            
            if let error = error{
                print("DEBUG: Failed to sign in with error \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser()
            print("DEBUG: User log in")
        }
    }
    
    func register(withEmail email: String, password: String, fullname: String, username: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error{
                print("DEBUG: Failed to register with error \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            //self.userSession = user
            
            self.tempUserSession = user
            
            let data = ["email": email, 
                        "username": username.lowercased(),
                        "fullname": fullname, 
                        "uid": user.uid ]
//            let data = ["email": email,
//                        "username": username.lowercased(),
//                        "fullname": fullname]
            
            Firestore.firestore().collection("users")
                .document(user.uid)
                .setData(data){ _ in
                    self.didAuthenticateUser = true
                    print("DEBUG: Uploaded user data..")
                }
        }
    }
    
    func signOut(){
        //To show the login view UI
        userSession = nil
        
        //Backend user logout
        try? Auth.auth().signOut()
    }
    
    func uploadProfileImage (_ image: UIImage){
        guard let uid = tempUserSession?.uid else {return }
        
        ImageUploader.uploadImage(image: image) { profileImageUrl in
            Firestore.firestore().collection("users")
                .document(uid)
                .updateData(["profileImageUrl": profileImageUrl]) { _ in
                    self.userSession = self.tempUserSession
                    self.fetchUser()
                }
        }
    }
    
    func fetchUser(){
        guard let uid = self.userSession?.uid else { return }
        service.fetchUser(withUid: uid){
            user in
            self.currentUser = user
        }
    }
}
