//
//  FeedView.swift
//  MLModelTest
//
//  Created by Tihara Jayawickrama on 2023-12-25.
//

import SwiftUI

struct FeedView: View {
    @State private var showNewTweetView = false
    @ObservedObject var viewModel = FeedViewModel()
    var body: some View {
        ZStack (alignment: .bottomTrailing){
            ScrollView{
                LazyVStack{
                    ForEach(viewModel.tweets) { tweet in
                        TweetsRowView(tweet: tweet)
                            .padding()
                    }
                }
            }
            Button{
                showNewTweetView.toggle()
                
            } label:{
                ZStack{
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: "plus")
                        .frame(width:20, height: 20)
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                        .padding()
                }
                
                   
            }
            .padding()
            .fullScreenCover(isPresented: $showNewTweetView){
                NewTweetView()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    FeedView()
//}
