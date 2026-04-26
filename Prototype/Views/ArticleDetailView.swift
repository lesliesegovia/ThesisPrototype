
import Foundation
import SwiftUI

struct ArticleDetailView: View {
    let category: String
    let headline: String
    let details: String
    let image: ImageResource
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppTheme.Spacing.articleFeed) {
                
                // Article image
                Image(image)
                    .resizable()
                    .scaledToFit()

                
                VStack(alignment: .leading, spacing: AppTheme.Spacing.articleContent) {
                    
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
                    Text(details)
                        .font(AppTheme.Typography.articleBody)
                        .foregroundStyle(AppTheme.Colors.textSecondary)
                        .lineSpacing(6)
                }
                .padding(.horizontal, 15)
            }
        }
        .background(AppTheme.Colors.backgroundScreen)
    }
}

#Preview {
    NavigationStack {
        ArticleDetailView(
            category: "Technology",
            headline: "SwiftUI gets major performance improvements in latest release",
            details: "Developers report faster build times and smoother animations across all supported platforms.",
            image: .featured
        )
    }
}
