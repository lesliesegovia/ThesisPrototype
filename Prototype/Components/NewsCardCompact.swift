
import Foundation
import SwiftUI

struct NewsCardCompact: View {
    let category: String
    let headline: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // card image
            Rectangle()
                .fill(AppTheme.Colors.accentSecondary.opacity(0.3))
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            // card content
            VStack(alignment: .leading, spacing: 8) {
                // category label
                Text(category)
                    .font(AppTheme.Typography.categoryLabel)
                    .foregroundStyle(AppTheme.Colors.accentPrimary)
                // headline
                Text(headline)
                    .font(AppTheme.Typography.cardHeadline)
                    .foregroundStyle(AppTheme.Colors.textSecondary)
                    .lineLimit(2)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(height: 100)
        .padding(16)
        .background(AppTheme.Colors.backgroundPrimary)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    VStack(spacing: 12) {
        NewsCardCompact(
            category: "Technology",
            headline: "SwiftUI gets major performance improvements",
            description: "Developers report faster build times and smoother animations."
        )
        NewsCardCompact(
            category: "Sports",
            headline: "Championship results from last night",
            description: "An unexpected victory shakes up the standings."
        )
    }
    .padding()
}
