//
//  NetworkManager.swift
//  GitHubUserSearch
//
//  Created by Neeshu Kumar  on 09/07/25.
//

import Foundation
import Combine
import SystemConfiguration

class NetworkManager {
    private let session = URLSession.shared
    
    func fetch<T: Codable>(url: String, type: T.Type) -> AnyPublisher<T, APIError> {
        guard let url = URL(string: url) else {
            return Fail(error: APIError.networkError).eraseToAnyPublisher()
        }
        
        if !isConnectedToNetwork() {
            return Fail(error: APIError.networkError).eraseToAnyPublisher()
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        return session.dataTaskPublisher(for: url)
            .tryMap { data, response -> Data in
                guard let http = response as? HTTPURLResponse else {
                    throw APIError.networkError
                }
                switch http.statusCode {
                case 200..<300:
                    return data
                case 400..<500:
                    // Optional: decode API-specific error message
                    if let apiErr = try? decoder.decode(APIErrorMessage.self, from: data) {
                        throw APIError(message: apiErr.reason)
                    }
                    throw APIError.userNotFound
                case 500..<600:
                    throw APIError.serverError(statusCode: http.statusCode)
                default:
                    throw APIError.networkError
                }
            } // break out early if invalid
            .decode(type: T.self, decoder: decoder)
            .mapError { error in
                if let apiError = error as? APIError {
                    return apiError
                } else if error is DecodingError {
                    return APIError.decodingError
                } else {
                    return APIError.networkError
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

}

private func isConnectedToNetwork() -> Bool {
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
    zeroAddress.sin_family = sa_family_t(AF_INET)

    guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
            SCNetworkReachabilityCreateWithAddress(nil, $0)
        }
    }) else { return false }

    var flags: SCNetworkReachabilityFlags = []
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
        return false
    }
    return flags.contains(.reachable) && !flags.contains(.connectionRequired)
}
