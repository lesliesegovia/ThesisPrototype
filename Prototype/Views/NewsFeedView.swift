
import Foundation
import SwiftUI

struct NewsFeedView: View {
    
    @State private var selectedCategory = "Today"
    
    let categories = ["Today", "Technology", "Sports", "Politics", "Entertainment"]
    let articles = NewsData.articles
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    // Header
                    NewsHeader()
                    
                    // Category pills
                    CategoryFilterBar(selectedCategory: $selectedCategory, categories: categories)
                    
                    // CARDS
                    VStack(spacing: AppTheme.Spacing.newsFeed) {
                        ForEach(articles, id: \.headline) { article in
                            NavigationLink(destination: ArticleDetailView(
                                category: article.category,
                                headline: article.headline,
                                details: article.description,
                                image: article.imageName
                            )) {
                                switch article.cardType {
                                case .featured:
                                    NewsCardFeatured(
                                        category: article.category,
                                        headline: article.headline,
                                        description: article.description,
                                        image: .featured
                                    )
                                    .padding(.horizontal, 5)
                                case .compact:
                                    NewsCardCompact(
                                        category: article.category,
                                        headline: article.headline,
                                        description: article.description,
                                        image: .compact
                                    )
                                }
                            }
                            .buttonStyle(.plain)
                        }
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
