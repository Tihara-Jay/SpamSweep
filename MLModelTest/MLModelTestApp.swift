//
//  MLModelTestApp.swift
//  MLModelTest
//
//  Created by Tihara Jayawickrama on 2023-12-25.
//

import SwiftUI
import Firebase

@main
struct MLModelTestApp: App {

    @StateObject var viewModel = AuthViewModel()
    
    init (){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
            }
            .environmentObject(viewModel)
        }
    }
}
