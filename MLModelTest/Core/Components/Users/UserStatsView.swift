//
//  UserStatsView.swift
//  MLModelTest
//
//  Created by Tihara Jayawickrama on 2023-12-25.
//

import SwiftUI

struct UserStatsView: View {
    var body: some View {
        HStack (spacing: 24){
            HStack (spacing: 4){
                Text("933")
                    .bold()
                    .font(.subheadline)
                
                Text("Following")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            HStack(spacing: 4){
                Text("2.4K")
                    .font(.subheadline)
                    .bold()
                
                Text("Followers")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    UserStatsView()
}
