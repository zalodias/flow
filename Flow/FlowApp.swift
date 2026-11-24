import SwiftData
import SwiftUI

@main
struct FlowApp: App {
    var body: some Scene {
        WindowGroup {
            Text("Flow")
        }
        .modelContainer(for: [Event.self, Item.self, Project.self])
    }
}
