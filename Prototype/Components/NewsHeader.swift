
import Foundation
import SwiftUI

struct NewsHeader: View {
    var body: some View {
        Image(.logo)
            .resizable()
            .scaledToFit()
            .frame(width: 120, height: 30)
    }
}

#Preview {
    NewsHeader()
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppTheme.Colors.backgroundScreen)
}
