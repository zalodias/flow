import Foundation
import SwiftData

@Model
final class Item {
    var title: String
    var dueDay: Date
    var completedAt: Date?
    var project: Project?

    var isDone: Bool { completedAt != nil }

    init(title: String, dueDay: Date, project: Project? = nil) {
        self.title = title
        self.dueDay = Calendar.current.startOfDay(for: dueDay)
        self.project = project
    }
}
