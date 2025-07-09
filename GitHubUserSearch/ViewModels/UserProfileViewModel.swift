//
//  UserProfileViewModel.swift
//  GitHubUserSearch
//
//  Created by Neeshu Kumar on 09/07/25.
//

import Foundation
import Combine

class UserProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var detailedUser: GitHubUser?
    @Published var loadingState: LoadingState = .idle
    
    private var cancellables = Set<AnyCancellable>()
    private let gitHubService = GitHubService.shared
    
    init(user: User) {
        self.user = user
        fetchUserDetails()
    }
    
    private func fetchUserDetails() {
        loadingState = .loading
        
        gitHubService.getUser(username: user.login)
            .sink(
                receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self?.loadingState = .error(error)
                    }
                },
                receiveValue: { [weak self] user in
                    self?.detailedUser = user
                    self?.loadingState = .loaded
                }
            )
            .store(in: &cancellables)
    }

}
