//
//  AuthHeaderView.swift
//  MLModelTest
//
//  Created by Tihara Jayawickrama on 2023-12-26.
//

import SwiftUI

struct AuthHeaderView: View {
    let title : String
    let subTitle : String
    
    var body: some View {
        VStack{
            //header view
            VStack(alignment: .leading){
                HStack{
                    Spacer()
                }
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                Text(subTitle)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            }
            .frame(height: 260)
            .padding(.leading)
            .background(Color(.black))
            .foregroundColor(.white)
            .clipShape(RoundedShape(corners: [.bottomRight]))
        }
    }
}

#Preview {
    AuthHeaderView(title: "Hello", subTitle: "Welcome Back")
}
