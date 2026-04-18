
import Foundation
import SwiftUI

struct NewsFeedView: View {
    
    @State private var selectedCategory = "Today"
    
    let categories = ["Today", "Technology", "Sports", "Politics", "Entertainment"]
    
    var body: some View {
        NavigationStack {
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
                    
                    // CARDS
                    // Featured card
                    NavigationLink(destination: ArticleDetailView (
                        category: "Breaking News",
                        headline: "Major developments unfold as global leaders meet for summit",
                        articleText: "Representatives from over 50 countries gathered to address climate and economic policy."
                    )) {
                        NewsCardFeatured(category: "Breaking News", headline: "Major developments unfold as global leaders meet for summit", description: "Representatives from over 50 countries gathered to address climate and economic policy.")
                            .padding(.horizontal, 5)
                    }
                    .buttonStyle(.plain)
                    
                    // compact cards
                    VStack(spacing: 12) {
                        NavigationLink(destination: ArticleDetailView(
                            category: "Technology",
                            headline: "SwiftUI gets major performance improvements in latest release",
                            articleText: "Developers report faster build times and smoother animations."
                        )) {
                            NewsCardCompact(
                                category: "Technology",
                                headline: "SwiftUI gets major performance improvements in latest release",
                                description: "Developers report faster build times and smoother animations."
                            )
                        }
                        .buttonStyle(.plain)
                        
                        NavigationLink(destination: ArticleDetailView(
                            category: "Sports",
                            headline: "Championship results shake up the standings",
                            articleText: "An unexpected victory changes everything heading into the finals."
                        )) {
                            NewsCardCompact(
                                category: "Sports",
                                headline: "Championship results shake up the standings",
                                description: "An unexpected victory changes everything heading into the finals."
                            )
                        }
                        .buttonStyle(.plain)
                        
                        NavigationLink(destination: ArticleDetailView(
                            category: "Science",
                            headline: "Researchers discover new approach to renewable energy storage",
                            articleText: "The breakthrough could significantly reduce costs for solar infrastructure."                        )) {
                            NewsCardCompact(
                                category: "Science",
                                headline: "Researchers discover new approach to renewable energy storage",
                                description: "The breakthrough could significantly reduce costs for solar infrastructure."
                            )
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal, 5)
                }
            }
            .background(AppTheme.Colors.backgroundScreen)
        }
    }
}

#Preview {
    NewsFeedView()
}
