//
//  UserSearchViewModel.swift
//  GitHubUserSearch
//
//  Created by Neeshu Kumar on 09/07/25.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var users: [User] = []
    @Published var loadingState: LoadingState = .idle
    @Published var hasMorePages = true
    
    private var cancellables = Set<AnyCancellable>()
    private let gitHubService = GitHubService.shared
    private var currentPage = 1
    
    init() {
        setupSearch()
    }
    
    private func setupSearch() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] searchText in
                self?.searchUsers(query: searchText, isNewSearch: true)
            }
            .store(in: &cancellables)
    }
    
    func searchUsers(query: String, isNewSearch: Bool = false) {
        guard !query.isEmpty else {
            users = []
            loadingState = .idle
            return
        }
        
        if isNewSearch {
            currentPage = 1
            users = []
            hasMorePages = true
        }
        
        loadingState = .loading
        
        gitHubService.searchUsers(query: query, page: currentPage)
            .sink(
                receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self?.loadingState = .error(error)
                    }
                },
                receiveValue: { [weak self] result in
                    if result.items.isEmpty {
                        self?.users = []
                        self?.loadingState = .error(APIError.userNotFound)
                        self?.hasMorePages = false
                        return
                    }
                    
                    if isNewSearch {
                        self?.users = result.items
                    } else {
                        self?.users.append(contentsOf: result.items)
                    }
                    
                    self?.loadingState = .loaded
                    self?.hasMorePages = result.items.count == 30
                    self?.currentPage += 1
                }
            )
            .store(in: &cancellables)
    }
    
    func loadMoreUsers() {
        guard hasMorePages && loadingState != .loading else { return }
        searchUsers(query: searchText, isNewSearch: false)
    }
}
