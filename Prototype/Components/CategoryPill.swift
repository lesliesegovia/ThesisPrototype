
import Foundation
import SwiftUI

struct CategoryPill: View {
    let title: String
    let isSelected: Bool
    
    var body: some View {
        Text(title)
            .font(AppTheme.Typography.categoryLabel)
            .foregroundStyle(
                isSelected ? AppTheme.Colors.textPrimary : AppTheme.Colors.accentSecondary
            )
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(isSelected ? AppTheme.Colors.accentPrimary : AppTheme.Colors.backgroundPrimary)
            )
    }
}

#Preview {
    HStack {
        CategoryPill(title: "All", isSelected: true)
        CategoryPill(title: "Technology", isSelected: false)
        CategoryPill(title: "Sports", isSelected: false)
    }
}
