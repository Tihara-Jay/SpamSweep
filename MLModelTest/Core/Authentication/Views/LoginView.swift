//
//  LoginView.swift
//  MLModelTest
//
//  Created by Tihara Jayawickrama on 2023-12-26.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var pw = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack{
        AuthHeaderView(title: "Hello", subTitle: "Welcome Back")
            
            VStack(spacing: 40){
                CustomInputField(imageName: "envelope", placeHolderText: "Email", isSecureField: false, text: $email)
                CustomInputField(imageName: "lock", placeHolderText: "Password",  isSecureField: true, text: $pw)
                
            }
            .padding(.horizontal, 32)
            .padding(.top, 44)
        
            HStack{
                Spacer()
                NavigationLink{
                    Text("Reset password view...")
                }
            label:
                {
                    Text("Forgot password?")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.white))
                        .padding(.top)
                        .padding(.trailing, 24)
                }
            }
            
            Button{
                viewModel.login(withEmail: email, password: pw)
            } label:{
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(Color(.black))
                    .clipShape(Capsule())
                    .padding()
            }
            .shadow(color: .gray, radius:10, x:0, y:0)
            
            Spacer()
        
            NavigationLink{
                RegistrationView()
                    .navigationBarHidden(true)
            } label:{
                HStack{
                    Text("Don't have an account?")
                        .font(.footnote)
                        .foregroundColor(.white)
                    
                    Text("Sign Up")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
            }
            .padding(.bottom, 32)
            .foregroundColor(Color(.black))
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
       
}

#Preview {
    LoginView()
}
