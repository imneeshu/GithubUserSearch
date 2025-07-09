//
//  GitHubAPIService.swift
//  GitHubUserSearch
//
//  Created by Neeshu Kumar  on 09/07/25.
//

import Foundation
import Combine

class GitHubService: ObservableObject {
    static let shared = GitHubService()
    private let baseURL = "https://api.github.com"
    private let networkManager = NetworkManager()
    
    private init() {}
    
    func searchUsers(query: String, page: Int = 1) -> AnyPublisher<UserSearchResult, APIError> {
        guard !query.isEmpty else {
            return Fail(error: APIError(message: "Please enter a username"))
                .eraseToAnyPublisher()
        }
        
        let url = "\(baseURL)/search/users?q=\(query)&page=\(page)&per_page=30"
        return networkManager.fetch(url: url, type: UserSearchResult.self)
    }
    
    func getUser(username: String) -> AnyPublisher<GitHubUser, APIError> {
        let url = "\(baseURL)/users/\(username)"
        return networkManager.fetch(url: url, type: GitHubUser.self)
    }
    
    
    func getFollowers(url: String) -> AnyPublisher< [Follower], APIError> {
        return networkManager.fetch(url: url, type: [Follower].self)
    }
    
    func getUserRepositories(username: String, page: Int = 1) -> AnyPublisher<[Repository], APIError> {
        let url = "\(baseURL)/users/\(username)/repos?page=\(page)&per_page=30&sort=updated"
        return networkManager.fetch(url: url, type: [Repository].self)
    }
}
