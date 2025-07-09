//
//  UserSearchView.swift
//  GitHubUserSearch
//
//  Created by Neeshu Kumar on 09/07/25.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @EnvironmentObject var theme: ThemeManager
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack(spacing: 0) {
            headerView
            
            VStack(spacing: 20) {
                AnimatedSearchBar(searchText: $viewModel.searchText)
                
                contentView
            }
            .padding()
        }
        .background(Color.backgroundColor)
        .navigationBarHidden(true)
    }
    
    private var headerView: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 6) {
                // Animated "Hey Folks"
                Text("Hey Folks 👋")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.primary)
                
                // Professional subtitle
                Text("Search users by username")
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                    .foregroundColor(.secondary)
            }

            Spacer()

            ThemeToggleButton()
        }
        .padding(.horizontal)
        .padding(.top, 12)
    }

    @ViewBuilder
    private var contentView: some View {
        switch viewModel.loadingState {
        case .idle:
            emptyStateView
        case .loading where viewModel.users.isEmpty:
            LoadingView()
        case .error(let error):
            ErrorView(error: error) {
                viewModel.searchUsers(query: viewModel.searchText)
            }
        default:
            userListView
        }
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 60))
                .foregroundColor(.secondary)
            
            Text("Search for GitHub Users")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
            
            Text("Enter a username to discover developers and their repositories")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var userListView: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(viewModel.users) { user in
                    UserRowView(user: user) {
                        router.navigate(to: .userProfile(user))
                    }
                    .onAppear {
                        if user.id == viewModel.users.last?.id {
                            viewModel.loadMoreUsers()
                        }
                    }
                }
                
                if viewModel.loadingState == .loading {
                    ProgressView()
                        .padding()
                }
            }
            .padding(.vertical)
        }
        .refreshable {
            viewModel.searchUsers(query: viewModel.searchText, isNewSearch: true)
        }
    }
}
