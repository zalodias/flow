import SwiftData

@Model
final class Project {
    var name: String
    var isArchived = false
    @Relationship(inverse: \Event.project) var events: [Event] = []
    @Relationship(inverse: \Item.project) var items: [Item] = []

    init(name: String) {
        self.name = name
    }
}
