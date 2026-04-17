
import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CategoryPill(title: "Today", isSelected: true)
            CategoryPill(title: "Technology", isSelected: false)
            CategoryPill(title: "Politics", isSelected: false)
        }
    }
}

#Preview {
    ContentView()
}
