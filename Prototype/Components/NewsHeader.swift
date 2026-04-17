
import Foundation
import SwiftUI

struct NewsHeader: View {
    var body: some View {
        Text("NEWS")
            .font(AppTheme.Typography.screenTitle)
            .foregroundStyle(AppTheme.Colors.textOnAccent)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(AppTheme.Colors.accentPrimary)
            )
    }
}

#Preview {
    NewsHeader()
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppTheme.Colors.backgroundScreen)
}
