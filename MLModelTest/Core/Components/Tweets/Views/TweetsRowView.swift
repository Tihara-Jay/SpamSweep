//
//  TweetsRowView.swift
//  MLModelTest
//
//  Created by Tihara Jayawickrama on 2023-12-25.
//

import SwiftUI
import Kingfisher

struct TweetsRowView: View {
    @ObservedObject var viewModel: TweetRowViewModel
    
    init(tweet: Tweet){
        self.viewModel = TweetRowViewModel(tweet: tweet)
        viewModel.fetchTweets()
    }
    
    var body: some View {
        VStack (alignment:.leading){
            if let user = viewModel.tweet.user {
                //profile image + user info + tweet
                HStack(alignment: .top, spacing: 12){
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width:56, height:56)
                        .clipShape(Circle())
                    
                    //user info and tweet caption
                    VStack (alignment: .leading, spacing: 4){
                        
                        //user info
                        HStack{
                            Text(user.fullname)
                                .font(.subheadline).bold()
                            Text("@\(user.username)")
                                .foregroundColor(.gray)
                                .font(.caption)
                            Text("2w")
                                .foregroundColor(.gray)
                                .font(.caption)
                        }
                        
                        
                        //tweet caption
                        Text(viewModel.tweet.caption)
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom)
                        Spacer()
                        if let imageUrlString = viewModel.tweet.imageUrl, let imageUrl = URL(string: imageUrlString) {
                            KFImage(imageUrl)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .aspectRatio(contentMode: .fit)
                                .padding()
                        } else {
                           
                        }
                    }
                }}
            //action buttons
            HStack{
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "bubble.left")
                        .font(.subheadline)
                })
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "arrow.2.squarepath")
                        .font(.subheadline)
                })
                Spacer()
                Button{
                    viewModel.likeTweet()
                }
                label: {
                    Image(systemName: viewModel.tweet.didLike ?? false ? "heart.fill" : "heart")
                        .font(.subheadline)
                        .foregroundColor(viewModel.tweet.didLike ?? false ? .red : .gray)
                }
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "bookmark")
                        .font(.subheadline)
                })
                .padding()
               
            }
            .padding()
            .foregroundColor(.gray)
            Divider()
        }
        .onAppear{
            viewModel.reloadTweets()
        }
     
    }
}

//#Preview {
//    TweetsRowView()
//}
