//
//  GitHubUser.swift
//  GitHubUserSearch
//
//  Created by Neeshu Kumar  on 09/07/25.
//

import Foundation

struct User: Codable, Identifiable, Hashable {
    let login: String
    let id: Int
    let nodeID: String
    let avatarURL: URL
    let gravatarID: String
    let url: URL
    let htmlURL: URL
    let followersURL: URL
    let followingURL: String
    let gistsURL: String
    let starredURL: String
    let subscriptionsURL: URL
    let organizationsURL: URL
    let reposURL: URL
    let eventsURL: String
    let receivedEventsURL: URL
    let type: String
    let userViewType: String
    let siteAdmin: Bool
    let score: Double
    
    private enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case userViewType = "user_view_type"
        case siteAdmin = "site_admin"
        case score
    }
}


// This represents the search JSON returned by GitHub's /search/users endpoint
struct UserSearchResult: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [User]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

// Represents the minimal info per user from the search results
struct SearchUser: Codable, Identifiable, Hashable {
    let id: Int
    let login: String
    let avatarUrl: URL
    let htmlUrl: URL

    enum CodingKeys: String, CodingKey {
        case id, login
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
    }
}



struct GitHubUser: Codable, Identifiable, Hashable {
    let login: String
    let id: Int
    let nodeID: String?
    let avatarURL: URL?
    let gravatarID: String?
    let url: URL?
    let htmlURL: URL?
    let followersURL: URL?
    let followingURL: String?
    let gistsURL: String?
    let starredURL: String?
    let subscriptionsURL: URL?
    let organizationsURL: URL?
    let reposURL: URL?
    let eventsURL: String?
    let receivedEventsURL: URL?
    let type: String?
    let userViewType: String?
    let siteAdmin: Bool
    let name: String?
    let company: String?
    let blog: String
    let location: String?
    let email: String?
    let hireable: Bool?
    let bio: String?
    let twitterUsername: String?
    let publicRepos: Int?
    let publicGists: Int?
    let followers: Int?
    let following: Int?
    let createdAt: Date
    let updatedAt: Date

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case userViewType = "user_view_type"
        case siteAdmin = "site_admin"
        case name, company, blog, location, email, hireable, bio
        case twitterUsername = "twitter_username"
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case followers, following
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


struct Follower: Codable {
    let login: String
    let id: Int
    let nodeId: String
    let avatarUrl: URL
    let htmlUrl: URL
    let type: String
    let userViewType: String
    let siteAdmin: Bool

    private enum CodingKeys: String, CodingKey {
        case login, id
        case nodeId = "node_id"
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
        case type
        case userViewType = "user_view_type"
        case siteAdmin = "site_admin"
    }
}
