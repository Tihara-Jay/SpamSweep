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
    @State private var isSpamTweet : Bool = false
    
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
                            
                            if let timeAgo = timeAgoString(from: viewModel.tweet.timestamp.dateValue()){
                                Text(timeAgo)
                                    .foregroundColor(.gray)
                                    .font(.caption)
                            }
                            
                            if viewModel.tweet.isImageSpam ?? false || viewModel.tweet.isTextSpam ?? false {
                                
                                    Image(systemName: "exclamationmark.triangle.fill")
                                        .foregroundColor(.red)
                                }
                     
                        }
                    if viewModel.tweet.isImageSpam ?? false || viewModel.tweet.isTextSpam ?? false {
                                ZStack{
                                    Rectangle()
                                        .fill(Color.red.opacity(0.2))
                                        .cornerRadius(8)
                                        .frame(width:300, height:20)
                                    Text("Tweet with potential spam has been detected!")
                                        .font(.caption)
                                        .foregroundColor(.red)
                                }
                            }
                
                        //tweet caption
                        Text(viewModel.tweet.caption ?? "")
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                            //.padding(.bottom)
                        Spacer()
                        if let imageUrlString = viewModel.tweet.imageUrl, let imageUrl = URL(string: imageUrlString) {
                            KFImage(imageUrl)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 200, height: 200)
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(10)
                                //.padding()
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
    
    private func timeAgoString (from date: Date) -> String? {
        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.weekOfYear, .day, .hour, .minute, .second], from: date, to: now)
        
        if let weeks = components.weekOfYear, weeks > 0 {
            return "\(weeks)w"
        }
        else if let days = components.day, days > 0 {
            return "\(days)d"
        }
        else if let hours = components.hour, hours > 0 {
            return "\(hours)h"
        }
        else if let mins = components.minute, mins > 0 {
            return "\(mins)m"
        }
        else if let secs = components.second, secs > 0 {
            return "\(secs)s"
        }
        return nil
    }
}

//#Preview {
//    TweetsRowView()
//}
