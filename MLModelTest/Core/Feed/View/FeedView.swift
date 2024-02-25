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
                Image(systemName: "plus.circle.fill")
                    .frame(width:80, height: 80)
                    .font(.system(size: 49))
                    .foregroundColor(.black)
                    .padding()
                   
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
