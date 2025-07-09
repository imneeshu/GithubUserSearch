//
//  ThemeToggleButton.swift
//  GitHubUserSearch
//
//  Created by Neeshu Kumar on 09/07/25.
//

import SwiftUI

struct ThemeToggleButton: View {
    @EnvironmentObject var theme: ThemeManager
    @State private var isAnimating = false
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.3)) {
                isAnimating = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                theme.toggleTheme()
                withAnimation(.easeInOut(duration: 0.3)) {
                    isAnimating = false
                }
            }
        }) {
            Image(systemName: theme.colorScheme == .light ? "moon.fill" : "sun.max.fill")
                .font(.title2)
                .foregroundColor(.primaryBlue)
                .scaleEffect(isAnimating ? 1.3 : 1.0)
                .rotationEffect(.degrees(isAnimating ? 180 : 0))
                .animation(.easeInOut(duration: 0.3), value: isAnimating)
        }
        .frame(width: 44, height: 44)
        .background(Color.cardBackground)
        .clipShape(Circle())
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}
