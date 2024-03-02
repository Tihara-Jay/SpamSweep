//
//  NewTweetView.swift
//  MLModelTest
//
//  Created by Tihara Jayawickrama on 2023-12-26.
//

import SwiftUI
import Kingfisher

struct NewTweetView: View {
    @State private var caption = ""
    @State private var selectedImage : UIImage?
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authViewModel : AuthViewModel
    @ObservedObject var viewModel = UploadTweetViewModel()
    @State private var showingImagePicker = false
    
    var body: some View {
        VStack{
            HStack{
                Button{
                    presentationMode.wrappedValue.dismiss()
                } label:{
                    Text("Cancel")
                        .background(Color(.black))
                        .foregroundColor(.white)
                }
                Spacer()
                Button{
                    viewModel.uploadTweet(withCaption: caption, uploadedImage: selectedImage)
                } label:{
                    Text("Post")
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color(.black))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
            }
            .padding()
            
            VStack{
                HStack (alignment: .top){
                    if let user = authViewModel.currentUser{
                        KFImage(URL(string: user.profileImageUrl))
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 64, height: 64)
                        
                    }
                    TextArea("What's happening?", text: $caption)
                    
                }
                if let image = selectedImage{
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                }
                HStack{
                    Button{
                        
                    } label:{
                        
                        Image(systemName: "waveform")
                            .frame(width:50, height: 50)
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                            .padding()
                        
                    }
                    
                    
                    Button{
                        showingImagePicker.toggle()
                        
                    } label:{
                        
                        Image(systemName: "photo")
                            .frame(width:50, height: 50)
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                            .padding()
                        
                    }
                    .sheet(isPresented: $showingImagePicker){
                        ImagePicker(selectedImage: $selectedImage)
                    }
                    Button{
                        
                    } label:{
                        
                        Image(systemName: "checklist")
                            .frame(width:50, height: 50)
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                            .padding()
                        
                    }
                    Button{
                        
                    } label:{
                        
                        Image(systemName: "mappin")
                            .frame(width:50, height: 50)
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                            .padding()
                        
                    }
                }
                
                .padding()
            }


        }
        .onReceive(viewModel.$didUploadTweet){
            success in
            if success {
          
                presentationMode.wrappedValue.dismiss()
                
            }
        }
    }


}


//#Preview {
//    NewTweetView()
//}
