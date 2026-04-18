
import Foundation
import SwiftUI

struct NewsFeedView: View {
    
    @State private var selectedCategory = "Today"
    
    let categories = ["Today", "Technology", "Sports", "Politics"]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                // Header
                NewsHeader()
                
                // Category pills
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8){
                        ForEach(categories, id: \.self) { category in
                            CategoryPill(
                                title: category,
                                isSelected: selectedCategory == category,
                            )
                            .onTapGesture {
                                selectedCategory = category
                            }
                        }
                    }
                    .padding(.horizontal, 5)
                }
                
                // Cards
                // Featured card
                NewsCardFeatured(category: "Breaking News", headline: "Major developments unfold as global leaders meet for summit", description: "Representatives from over 50 countries gathered to address climate and economic policy.")
                    .padding(.horizontal, 5)
                
                // compact cards
                VStack(spacing: 12) {
                    NewsCardCompact(
                        category: "Technology",
                        headline: "SwiftUI gets major performance improvements in latest release",
                        description: "Developers report faster build times and smoother animations."
                    )
                    NewsCardCompact(
                        category: "Sports",
                        headline: "Championship results shake up the standings",
                        description: "An unexpected victory changes everything heading into the finals."
                    )
                    NewsCardCompact(
                        category: "Science",
                        headline: "Researchers discover new approach to renewable energy storage",
                        description: "The breakthrough could significantly reduce costs for solar infrastructure."
                    )
                }
                .padding(.horizontal, 5)
            }
            .background(AppTheme.Colors.backgroundScreen)
        }
    }
}

#Preview {
    NewsFeedView()
}
