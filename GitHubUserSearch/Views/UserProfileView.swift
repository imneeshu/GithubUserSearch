//
//  UserProfileView.swift
//  GitHubUserSearch
//
//  Created by Neeshu Kumar on 09/07/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserProfileView: View {
    @StateObject private var viewModel: UserProfileViewModel
    @EnvironmentObject var router: Router
    
    init(user: User) {
        _viewModel = StateObject(wrappedValue: UserProfileViewModel(user: user))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                profileHeader
                
                if let detailedUser = viewModel.detailedUser {
                    profileDetails(user: detailedUser)
                    
                    repositoryButton(user: detailedUser)
                }
            }
            .padding()
        }
        .background(Color.backgroundColor)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Profile")
    }
    
    private var profileHeader: some View {
        VStack(spacing: 16) {
            WebImage(url: viewModel.user.avatarURL) { image in
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
            
            VStack(spacing: 4) {
                Text(viewModel.user.login)
                    .font(.title)
                    .fontWeight(.bold)
                
                if let name = viewModel.detailedUser?.name {
                    Text(name)
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
                
                if let bio = viewModel.detailedUser?.bio {
                    Text(bio)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.top, 8)
                }
            }
        }
    }
    
    private func profileDetails(user: GitHubUser) -> some View {
        VStack(spacing: 16) {
            HStack{
                statCard(
                    title: "Followers",
                    value: "\(String(describing: (viewModel.detailedUser?.followers)!))",
                    icon: "person.2"
                )
                statCard(
                    title: "Repositories",
                    value: "\(String(describing: (viewModel.detailedUser?.publicRepos)!))",
                    icon: "folder"
                )
            }
            
            if let location = user.location {
                infoRow(icon: "location", text: location)
            }
            
            if let company = user.company {
                infoRow(icon: "building.2", text: company)
            }
            
            if !user.blog.isEmpty {
                infoRow(icon: "link", text: user.blog)
            }
        }
        .padding()
        .background(Color.cardBackground)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
    
    private func statCard(title: String, value: String, icon: String) -> some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.primaryBlue)
            
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.backgroundColor)
        .cornerRadius(12)
    }
    
    private func infoRow(icon: String, text: String) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.primaryBlue)
                .frame(width: 20)
            
            Text(text)
                .foregroundColor(.primary)
            
            Spacer()
        }
    }
    
    private func repositoryButton(user: GitHubUser) -> some View {
        Button(action: {
            router.navigate(to: .repositories(user))
        }) {
            HStack {
                Image(systemName: "folder.fill")
                Text("View Repositories")
                    .fontWeight(.semibold)
                Spacer()
                Image(systemName: "chevron.right")
            }
            .foregroundColor(.white)
            .padding()
            .background(Color.primaryBlue)
            .cornerRadius(16)
        }
        .shadow(color: Color.primaryBlue.opacity(0.3), radius: 8, x: 0, y: 4)
    }
}

