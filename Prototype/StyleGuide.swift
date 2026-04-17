
import Foundation
import SwiftUI

struct AppTheme {
    
    struct Colors {
        // Accents
        static let accentPrimary = Color("#7C3AED")
        static let accentSecondary = Color("#009688")
        
        // Backgrounds
        static let backgroundPrimary = Color("#2C2C2C")
        static let backgroundScreen = Color("#151414")
        
        // Text
        static let textPrimary = Color("#EFEFEF")
        static let textSecondary = Color("#DAD7D7")
        static let textOnAccent = Color("#F8F8F8")
    }
    
    struct Typography {
        static let screenTitle = Font.system(size: 18, weight: .bold)
        static let cardHeadline = Font.system(size: 16, weight: .semibold)
        static let cardBody = Font.system(size: 13, weight: .regular)
        static let categoryLabel = Font.system(size: 12, weight: .medium)
    }
}
