//
//  RepositoriesView.swift
//  GitHubUserSearch
//
//  Created by Neeshu Kumar on 09/07/25.
//

import SwiftUI

struct RepositoryListView: View {
    @StateObject private var viewModel: RepositoryViewModel
    @EnvironmentObject var router: Router
    
    init(user: GitHubUser) {
        _viewModel = StateObject(wrappedValue: RepositoryViewModel(user: user))
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(viewModel.repositories) { repository in
                    RepositoryRowView(repository: repository)
                        .onAppear {
                            if repository.id == viewModel.repositories.last?.id {
                                viewModel.loadMoreRepositories()
                            }
                        }
                }
                
                if viewModel.loadingState == .loading {
                    ProgressView()
                        .padding()
                }
            }
            .padding()
        }
        .background(Color.backgroundColor)
        .navigationTitle("Repositories")
        .navigationBarTitleDisplayMode(.large)
        .refreshable {
            viewModel.refresh()
        }
    }
}
