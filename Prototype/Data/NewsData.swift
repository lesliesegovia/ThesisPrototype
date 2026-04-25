
import Foundation

struct NewsData {
    static let articles: [NewsArticle] = [
        NewsArticle(
            category: "Breaking News",
            headline: "Major developments unfold as global leaders meet for summit",
            description: "Representatives from over 50 countries gathered to address climate and economic policy.",
            cardType: .featured
        ),
        NewsArticle(
            category: "Technology",
            headline: "SwiftUI gets major performance improvements in latest release",
            description: "Developers report faster build times and smoother animations.",
            cardType: .compact
        ),
        NewsArticle(
            category: "Sports",
            headline: "Championship results shake up the standings",
            description: "An unexpected victory changes everything heading into the finals.",
            cardType: .compact
        ),
        NewsArticle(
            category: "Science",
            headline: "Researchers discover new approach to renewable energy storage",
            description: "The breakthrough could significantly reduce costs for solar infrastructure.",
            cardType: .compact
        )
    ]
}
