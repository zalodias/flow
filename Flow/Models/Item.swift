import Foundation
import SwiftData

@Model
final class Item {
    var title: String
    var due: Date
    var done: Date?
    var project: Project?

    init(title: String, due: Date, project: Project? = nil) {
        self.title = title
        self.due = Calendar.current.startOfDay(for: due)
        self.project = project
    }
}
