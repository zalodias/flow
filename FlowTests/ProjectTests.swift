import Foundation
import SwiftData
import Testing
@testable import Flow

struct ProjectTests {
    @Test func deletingAProjectLeavesItsEventsAndItemsUnfiled() throws {
        let context = ModelContext(try ModelContainer(for: Project.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true)))
        let project = Project(name: "Northwind")
        context.insert(Event(title: "Kickoff", start: .now, end: .now.addingTimeInterval(3600), project: project))
        context.insert(Item(title: "Send invoice", dueDay: .now, project: project))
        try context.save()

        context.delete(project)
        try context.save()

        #expect(try context.fetch(FetchDescriptor<Event>()).map(\.project) == [nil])
        #expect(try context.fetch(FetchDescriptor<Item>()).map(\.project) == [nil])
    }
}
