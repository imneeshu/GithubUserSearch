//
//  Constants.swift
//  GitHubUserSearch
//
//  Created by Neeshu Kumar  on 09/07/25.
//

import Foundation

struct Constants {
    static let githubBaseURL = "https://api.github.com"
    static let defaultPerPage = 30
    static let maxSearchResults = 1000
    
    struct API {
        static let rateLimitRemaining = "X-RateLimit-Remaining"
        static let rateLimitReset = "X-RateLimit-Reset"
    }
}
