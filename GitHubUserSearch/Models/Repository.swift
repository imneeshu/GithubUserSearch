//
//  GitHubRepository.swift
//  GitHubUserSearch
//
//  Created by Neeshu Kumar  on 09/07/25.
//

import Foundation

struct Repository: Codable, Identifiable {
    let id: Int
    let name: String
    let description: String?
    let htmlUrl: String
    let stargazersCount: Int
    let forksCount: Int
    let language: String?
    let updatedAt: String
    let isPrivate: Bool
    let url : URL
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, language, url
        case htmlUrl = "html_url"
        case stargazersCount = "stargazers_count"
        case forksCount = "forks_count"
        case updatedAt = "updated_at"
        case isPrivate = "private"
    }
}
