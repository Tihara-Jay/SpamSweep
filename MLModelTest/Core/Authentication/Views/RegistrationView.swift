//
//  RegistrationView.swift
//  MLModelTest
//
//  Created by Tihara Jayawickrama on 2023-12-26.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var username = ""
    @State private var fullname = ""
    @State private var pw = ""
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel : AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack{
                
                NavigationLink(destination: ProfilePhotoSelectorView(),
                               isActive: $viewModel.didAuthenticateUser) {}
                
                
                
                AuthHeaderView(title: "Get Started.", subTitle: "Create your account")
                VStack(spacing: 40){
                    CustomInputField(imageName: "envelope", placeHolderText: "Email", isSecureField: false, text: $email)
                    CustomInputField(imageName: "person", placeHolderText: "Username", isSecureField: false, text: $username)
                    CustomInputField(imageName: "person", placeHolderText: "Full Name", isSecureField: false, text: $fullname)
                    CustomInputField(imageName: "lock", placeHolderText: "Password", isSecureField: true, text: $pw)
                }
                .padding(30)
                
                Button{
                    viewModel.register(withEmail: email,
                                       password: pw,
                                       fullname: fullname,
                                       username: username)
                } label:{
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 340, height: 50)
                        .background(Color(.black))
                        .clipShape(Capsule())
                        .padding()
                }
                .shadow(color: .gray, radius:10, x:0, y:0)
                
                Spacer()
                
                Button{
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack{
                        Text("Already have an account?")
                            .font(.footnote)
                        
                        Text("Sign In")
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                }
                .padding(.bottom, 32)
                .foregroundColor(Color(.black))
            }
            .ignoresSafeArea()
        }
    }
}

//#Preview {
//    RegistrationView()
//}
