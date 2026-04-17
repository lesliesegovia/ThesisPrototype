
import Foundation
import SwiftUI

struct NewsCardFeatured: View {
    let category: String
    let headline: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            // Card image
            Rectangle()
                .fill(AppTheme.Colors.accentSecondary.opacity(0.3))
                .frame(maxWidth: .infinity)
                .frame(height: 180)
                .clipShape(
                    UnevenRoundedRectangle(
                        topLeadingRadius: 12,
                        topTrailingRadius: 12
                    )
                )
            // Card content
            VStack(alignment: .leading, spacing: 8) {
                // category label
                Text(category)
                    .font(AppTheme.Typography.categoryLabel)
                    .foregroundStyle(AppTheme.Colors.accentPrimary)
                // headline
                Text(headline)
                    .font(AppTheme.Typography.cardHeadline)
                    .foregroundStyle(AppTheme.Colors.textPrimary)
                    .lineLimit(2)
                // description
                Text(description)
                    .font(AppTheme.Typography.cardBody)
                    .foregroundStyle(AppTheme.Colors.textSecondary)
                    .lineLimit(2)
            }
            .padding(16)
        }
        .background(AppTheme.Colors.backgroundPrimary)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    NewsCardFeatured(
        category: "Technology",
        headline: "Apple announces major updates to SwiftUI at WWDC",
        description: "New features include improved animations and enhanced layout tools for developers."
    )
    .padding()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(AppTheme.Colors.backgroundScreen)
}
