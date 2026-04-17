
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            NewsHeader()
            HStack {
                CategoryPill(title: "Today", isSelected: true)
                CategoryPill(title: "Technology", isSelected: false)
                CategoryPill(title: "Sports", isSelected: false)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(AppTheme.Colors.backgroundScreen)
    }
}

#Preview {
    ContentView()
}
