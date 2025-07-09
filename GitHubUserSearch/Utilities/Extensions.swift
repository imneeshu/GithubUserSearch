//
//  Extensions.swift
//  GitHubUserSearch
//
//  Created by Neeshu Kumar on 09/07/25.
//

import Foundation
import SwiftUI

extension String {
    func formattedDate() -> String {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: self) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            return displayFormatter.string(from: date)
        }
        return self
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension Color {
    static let githubBlue = Color(red: 0.1, green: 0.4, blue: 0.9)
    static let githubGreen = Color(red: 0.2, green: 0.7, blue: 0.3)
    static let githubOrange = Color(red: 1.0, green: 0.6, blue: 0.2)
}
