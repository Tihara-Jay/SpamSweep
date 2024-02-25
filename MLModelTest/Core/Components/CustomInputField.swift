//
//  CustomInputField.swift
//  MLModelTest
//
//  Created by Tihara Jayawickrama on 2023-12-26.
//

import SwiftUI

struct CustomInputField: View {
    let imageName : String
    let placeHolderText : String
    let isSecureField : Bool?
    @Binding var text : String
    var body: some View {
        VStack{
            HStack{
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(.darkGray))
                if isSecureField ?? false{
                    SecureField(placeHolderText, text: $text)
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                }
                else{
                    TextField(placeHolderText, text: $text)
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                }
            }
            Divider()
                .background(Color(.darkGray))
        }
    }
}

#Preview {
    CustomInputField(imageName: "envelope", placeHolderText: "Email", isSecureField: false, text: .constant(""))
}
