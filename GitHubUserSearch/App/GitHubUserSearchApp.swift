//
//  GitHubUserSearchApp.swift
//  GitHubUserSearch
//
//  Created by Neeshu Kumar  on 09/07/25.
//

import SwiftUI

@main
struct GitHubUserSearchApp: App {
    @StateObject private var theme = ThemeManager()
    @StateObject private var router = Router()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                ContentView()
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .userProfile(let user):
                            UserProfileView(user: user)
                        case .repositories(let user):
                            RepositoryListView(user: user)
                        }
                    }
            }
            .environmentObject(theme)
            .environmentObject(router)
            .preferredColorScheme(theme.colorScheme)
        }
    }
}
