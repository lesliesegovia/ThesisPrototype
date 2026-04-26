
import Foundation
import SwiftUI

struct CategoryFilterBar: View {
    @Binding var selectedCategory: String
    let categories: [String]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: AppTheme.Spacing.filterBar) {
                ForEach(categories, id: \.self) { category in
                    CategoryPill(
                        title: category,
                        isSelected: selectedCategory == category
                    )
                    .onTapGesture {
                        selectedCategory = category
                    }
                }
            }
            .padding(.horizontal, 5)
        }
    }
}
