//
//  TextArea.swift
//  MLModelTest
//
//  Created by Tihara Jayawickrama on 2023-12-26.
//

import SwiftUI

struct TextArea: View {
    @Binding var text: String
    let placeholder: String
    
    init(_ placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color(.placeholderText))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 12)
                    .zIndex(1)
            }
            
            TextEditor(text: $text)
                .padding(4)
                .background(Color.clear)
                .foregroundColor(Color.primary)
                .disableAutocorrection(true)

        }
        .font(.body)
    }
}

#Preview {
    TextArea("", text: .constant(""))
}
