//
//  RepositoriesViewModel.swift
//  GitHubUserSearch
//
//  Created by Neeshu Kumar on 09/07/25.
//

import Foundation
import Combine

class RepositoryViewModel: ObservableObject {
    @Published var repositories: [Repository] = []
    @Published var loadingState: LoadingState = .idle
    @Published var hasMorePages = true
    
    private var cancellables = Set<AnyCancellable>()
    private let gitHubService = GitHubService.shared
    private let user: GitHubUser
    private var currentPage = 1
    
    init(user: GitHubUser) {
        self.user = user
        fetchRepositories()
    }
    
    private func fetchRepositories(isNewSearch: Bool = true) {
        if isNewSearch {
            currentPage = 1
            repositories = []
            hasMorePages = true
        }
        
        loadingState = .loading
        
        gitHubService.getUserRepositories(username: user.login, page: currentPage)
            .sink(
                receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self?.loadingState = .error(error)
                    }
                },
                receiveValue: { [weak self] repos in
                    if isNewSearch {
                        self?.repositories = repos
                    } else {
                        self?.repositories.append(contentsOf: repos)
                    }
                    
                    self?.loadingState = .loaded
                    self?.hasMorePages = repos.count == 30
                    self?.currentPage += 1
                }
            )
            .store(in: &cancellables)
    }
    
    func loadMoreRepositories() {
        guard hasMorePages && loadingState != .loading else { return }
        fetchRepositories(isNewSearch: false)
    }
    
    func refresh() {
        fetchRepositories()
    }
}
