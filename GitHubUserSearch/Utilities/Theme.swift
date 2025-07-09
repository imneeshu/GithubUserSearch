//
//  Theme.swift
//  GitHubUserSearch
//
//  Created by Neeshu Kumar on 09/07/25.
//

import SwiftUI

class ThemeManager: ObservableObject {
    @Published var colorScheme: ColorScheme = .light
    
    func toggleTheme() {
        withAnimation(.easeInOut(duration: 0.5)) {
            colorScheme = colorScheme == .light ? .dark : .light
        }
    }
}

extension Color {
    static let primaryBlue = Color(red: 0.1, green: 0.4, blue: 0.9)
    static let secondaryGray = Color(red: 0.5, green: 0.5, blue: 0.5)
    static let backgroundColor = Color(UIColor.systemBackground)
    static let cardBackground = Color(UIColor.systemGray6)
}
