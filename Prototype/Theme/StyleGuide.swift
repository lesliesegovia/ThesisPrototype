
import Foundation
import SwiftUI

struct AppTheme {
    
    struct Colors {
        // Accents
        static let accentPrimary = Color("accentPrimary")
        static let accentSecondary = Color("accentSecondary")
        
        // Backgrounds
        static let backgroundPrimary = Color("backgroundPrimary")
        static let backgroundScreen = Color("backgroundScreen")
        
        // Text
        static let textPrimary = Color("textPrimary")
        static let textSecondary = Color("textSecondary")
        static let textOnAccent = Color("textOnAccent")
    }
    
    struct Typography {
        static let screenTitle = Font.system(size: 18, weight: .bold)
        
        // cards
        static let cardHeadline = Font.system(size: 16, weight: .semibold)
        static let cardBody = Font.system(size: 13, weight: .regular)
        static let categoryLabel = Font.system(size: 12, weight: .medium)
        
        // article
        static let articleHeadline = Font.system(size: 32, weight: .bold)
        static let articleBody = Font.system(size: 20, weight: .regular)
    }
}
