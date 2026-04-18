
import Foundation
import SwiftUI

enum CardType {
    case featured
    case compact
}

struct NewsArticle {
    let category: String
    let headline: String
    let description: String
    let cardType: CardType
    
    var imageName: ImageResource {
        switch cardType {
        case .compact:
            return .compact // image in assets
        case .featured:
            return .featured // image in assets
        }
    }
}
