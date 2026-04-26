
import Foundation
import SwiftUI

struct NewsHeader: View {
    var body: some View {
        HStack(spacing: AppTheme.Spacing.header) {
            Image(.logo)
                .resizable()
                .scaledToFit()
                .frame(height: 36)
            
            Text("NEWS")
                .font(AppTheme.Typography.screenTitle)
                .foregroundStyle(AppTheme.Colors.accentPrimary)
        }
    }
}

#Preview {
    NewsHeader()
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppTheme.Colors.backgroundScreen)
}
