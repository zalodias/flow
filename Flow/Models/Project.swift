import SwiftData

@Model
final class Project {
    enum Status: String, Codable {
        case active, inactive
    }

    var name: String
    var status = Status.active
    @Relationship(inverse: \Event.project) var events: [Event] = []
    @Relationship(inverse: \Item.project) var items: [Item] = []

    init(name: String) {
        self.name = name
    }
}
