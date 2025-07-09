//
//  AnimatedSearchBar.swift
//  GitHubUserSearch
//
//  Created by Neeshu Kumar on 09/07/25.
//

import SwiftUI

struct AnimatedSearchBar: View {
    @Binding var searchText: String
    @State private var isSearching = false
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                    .scaleEffect(isSearching ? 1.1 : 1.0)
                    .animation(.easeInOut(duration: 0.2), value: isSearching)
                
                TextField("Search users...", text: $searchText)
                    .textFieldStyle(PlainTextFieldStyle())
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            isSearching = true
                        }
                    }
                
                if !searchText.isEmpty {
                    Button(action: {
                        searchText = ""
                        withAnimation(.easeInOut(duration: 0.3)) {
                            isSearching = false
                        }
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                    }
                    .transition(.scale.combined(with: .opacity))
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.cardBackground)
            .cornerRadius(25)
            .scaleEffect(isSearching ? 1.02 : 1.0)
            .shadow(color: Color.black.opacity(0.1), radius: isSearching ? 8 : 4, x: 0, y: 2)
            .animation(.easeInOut(duration: 0.3), value: isSearching)
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.3)) {
                isSearching = false
            }
        }
    }
}
