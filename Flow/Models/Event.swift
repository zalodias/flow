import Foundation
import SwiftData

@Model
final class Event {
    var title: String
    var start: Date
    var end: Date
    var location: String?
    var project: Project?
    var recurrence: Recurrence?

    init(
        title: String,
        start: Date,
        end: Date,
        location: String? = nil,
        project: Project? = nil,
        recurrence: Recurrence? = nil
    ) {
        self.title = title
        self.start = start
        self.end = end
        self.location = location
        self.project = project
        self.recurrence = recurrence
    }

    func occurrences(in range: Range<Date>, calendar: Calendar = .current) -> [DateInterval] {
        let duration = end.timeIntervalSince(start)
        let starts = recurrence.map { recurrence in
            recurrence.rule(calendar: calendar)
                .recurrences(of: start, in: range.lowerBound.addingTimeInterval(-duration)..<range.upperBound)
                .filter { !recurrence.skip.contains($0) }
        } ?? [start]

        return starts
            .map { DateInterval(start: $0, duration: duration) }
            .filter { $0.start < range.upperBound && $0.end > range.lowerBound }
    }
}
