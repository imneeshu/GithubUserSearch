//
//  APIResponse.swift
//  GitHubUserSearch
//
//  Created by Neeshu Kumar  on 09/07/25.
//

import Foundation

struct APIErrorMessage: Codable {
    let reason: String
}

struct APIError: Error, LocalizedError {
    let message: String
    
    var errorDescription: String? {
        return message
    }
    
    static let userNotFound = APIError(message: "Invalid username. No user found with that name.")
    static let networkError = APIError(message: "Network error occurred")
    static let decodingError = APIError(message: "Failed to decode response")
    static func serverError(statusCode: Int, message: String? = nil) -> APIError {
           let msg = message ?? "Server error occurred (code: \(statusCode))"
           return APIError(message: msg)
       }
}

enum LoadingState{
    case idle
    case loading
    case loaded
    case error(APIError)
}

extension LoadingState: Equatable {
    static func == (lhs: LoadingState, rhs: LoadingState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle),
             (.loading, .loading),
             (.loaded, .loaded):
            return true
        case (.error(let e1), .error(let e2)):
            // Compare enough to deduce if same error
            return e1.localizedDescription == e2.localizedDescription
        default:
            return false
        }
    }
}
