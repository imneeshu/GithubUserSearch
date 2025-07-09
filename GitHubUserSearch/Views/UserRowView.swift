//
//  UserRowView.swift
//  GitHubUserSearch
//
//  Created by Neeshu Kumar on 09/07/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserRowView: View {
    let user: User
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 16) {
                WebImage(url: user.avatarURL) { image in
                    image
                        .resizable()
                }
                placeholder: {
                    Rectangle()
                        .foregroundColor(.gray.opacity(0.3))
                        .overlay(
                            Image(systemName: "person.fill")
                                .foregroundColor(.gray)
                        )
                }
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipShape(Circle())

                
                VStack(alignment: .leading, spacing: 4) {
                    Text(user.login)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
//                    if let name = user.login {
                        Text(user.login)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
//                    }
                    
//                    HStack {
//                        Label("\(user.reposURL)", systemImage: "folder")
//                        Spacer()
//                        Label("\(user.followersURL)", systemImage: "person.2")
//                    }
//                    .font(.caption)
//                    .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(Color.cardBackground)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
