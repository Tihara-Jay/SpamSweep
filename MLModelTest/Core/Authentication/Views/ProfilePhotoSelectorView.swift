//
//  ProfilePhotoSelectorView.swift
//  MLModelTest
//
//  Created by Tihara Jayawickrama on 2024-01-20.
//

import SwiftUI

struct ProfilePhotoSelectorView: View {
    @State private var showImagePicker = false
    @State private var selectedImage : UIImage?
    @State private var profileImage: Image?
    @EnvironmentObject var viewModel : AuthViewModel
    var body: some View {
        VStack{
            AuthHeaderView(title: "Create your account", subTitle: "Add a profile photo")
            
            Button{
                showImagePicker.toggle()
                print("Pick profile image here")
            } label: {
                if let profileImage = profileImage{
                    profileImage
                        .resizable()
                        .modifier(ProfileImageModifier())
                        
                }
                else{
                    Image("add_profile_photo_icon")
                        .resizable()
                        .modifier(ProfileImageModifier())
                }
            }
            .sheet(isPresented: $showImagePicker, onDismiss: loadImage){
                ImagePicker(selectedImage: $selectedImage)
            }
            .padding(.top, 44)
            
            if  selectedImage == selectedImage {
                Button{
                    viewModel.uploadProfileImage(selectedImage!)
                } label:{
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 340, height: 50)
                        .background(Color(.black))
                        .clipShape(Capsule())
                        .padding()
                }
                .shadow(color: .gray, radius:10, x:0, y:0)
            }
            
            Spacer()
        }
        .ignoresSafeArea()
    }
    
    func loadImage(){
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
    }
}

private struct ProfileImageModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .scaledToFill()
            .frame(width: 180, height: 180)
            .clipShape(Circle())
    }
}

#Preview {
    ProfilePhotoSelectorView()
}
