
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
                    VStack(spacing: 12) {
                        ForEach(articles, id: \.headline) { article in
                            NavigationLink(destination: ArticleDetailView(
                                category: article.category,
                                headline: article.headline,
                                articleText: article.description,
                                imageName: article.imageName
                            )) {
                                switch article.cardType {
                                case .featured:
                                    NewsCardFeatured(
                                        category: article.category,
                                        headline: article.headline,
                                        description: article.description
                                    )
                                    .padding(.horizontal, 5)
                                case .compact:
                                    NewsCardCompact(
                                        category: article.category,
                                        headline: article.headline,
                                        description: article.description
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
