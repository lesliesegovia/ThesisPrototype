
import Foundation
import SwiftUI

struct ArticleDetailView: View {
    let category: String
    let headline: String
    let articleText: String
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                // Article image
                Rectangle()
                    .fill(AppTheme.Colors.accentSecondary.opacity(0.3))
                    .frame(maxWidth: .infinity)
                    .frame(height: 220)
                
                VStack(alignment: .leading, spacing: 12) {
                    
                    // Category Label
                    CategoryPill(title: category, isSelected: true)
                    
                    // headline
                    Text(headline)
                        .font(AppTheme.Typography.articleHeadline)
                        .foregroundStyle(AppTheme.Colors.textPrimary)
                    
                    // divider
                    Rectangle()
                        .fill(AppTheme.Colors.backgroundPrimary)
                        .frame(maxWidth: .infinity)
                        .frame(height: 3)
                    
                    // article body
                    Text(articleText)
                        .font(AppTheme.Typography.articleBody)
                        .foregroundStyle(AppTheme.Colors.textSecondary)
                        .lineSpacing(6)
                }
                .padding(.horizontal, 15)
            }
        }
        .background(AppTheme.Colors.backgroundScreen)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(AppTheme.Colors.backgroundScreen, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
}

#Preview {
    NavigationStack {
        ArticleDetailView(
            category: "Technology",
            headline: "SwiftUI gets major performance improvements in latest release",
            articleText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        )
    }
}
