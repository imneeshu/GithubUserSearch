//
//  Router.swift
//  GitHubUserSearch
//
//  Created by Neeshu Kumar on 09/07/25.
//

import SwiftUI

enum Route: Hashable {
    case userProfile(User)
    case repositories(GitHubUser)
}

class Router: ObservableObject {
    @Published var path = NavigationPath()
    
    func navigate(to route: Route) {
        path.append(route)
    }
    
    func navigateBack() {
        path.removeLast()
    }
    
    func navigateToRoot() {
        path.removeLast(path.count)
    }
}
