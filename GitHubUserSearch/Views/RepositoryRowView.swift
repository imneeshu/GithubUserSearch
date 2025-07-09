//
//  RepositoryRowView.swift
//  GitHubUserSearch
//
//  Created by Neeshu Kumar on 09/07/25.
//

import SwiftUI

struct RepositoryRowView: View {
    let repository: Repository
    @State var isWebViewOpened : Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(repository.name)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primaryBlue)
                
                Spacer()
                
                if !repository.isPrivate {
                    Image(systemName: "lock.open")
                        .foregroundColor(.green)
                } else {
                    Image(systemName: "lock")
                        .foregroundColor(.orange)
                }
            }
            
            if let description = repository.description {
                Text(description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
            }
            
            HStack {
                if let language = repository.language {
                    languageLabel(language)
                }
                
                Spacer()
                
                statLabel(icon: "star", count: repository.stargazersCount)
                statLabel(icon: "tuningfork", count: repository.forksCount)
            }
        }
        .onTapGesture {
            isWebViewOpened = true
        }
        .padding()
        .background(Color.cardBackground)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
        .fullScreenCover(isPresented: $isWebViewOpened, content: {
            SafariView(url: URL(string: repository.htmlUrl)!)
        })
    }
    
    private func languageLabel(_ language: String) -> some View {
        Text(language)
            .font(.caption)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color.primaryBlue.opacity(0.2))
            .foregroundColor(.primaryBlue)
            .cornerRadius(8)
    }
    
    private func statLabel(icon: String, count: Int) -> some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
            Text("\(count)")
        }
        .font(.caption)
        .foregroundColor(.secondary)
    }
}
