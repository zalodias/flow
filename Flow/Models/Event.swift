import Foundation
import SwiftData

@Model
final class Event {
    var title: String
    var start: Date
    var end: Date
    var isAllDay: Bool
    var place: String?
    var project: Project?
    var recurrence: Recurrence?
    var skippedDates: [Date] = []

    init(
        title: String,
        start: Date,
        end: Date,
        isAllDay: Bool = false,
        place: String? = nil,
        project: Project? = nil,
        recurrence: Recurrence? = nil
    ) {
        self.title = title
        self.start = start
        self.end = end
        self.isAllDay = isAllDay
        self.place = place
        self.project = project
        self.recurrence = recurrence
    }

    func occurrences(in range: Range<Date>, calendar: Calendar = .current) -> [DateInterval] {
        let duration = end.timeIntervalSince(start)
        let starts = recurrence.map {
            Array($0.rule(calendar: calendar).recurrences(of: start, in: range.lowerBound.addingTimeInterval(-duration)..<range.upperBound))
        } ?? [start]

        return starts
            .filter { !skippedDates.contains($0) }
            .map { DateInterval(start: $0, duration: duration) }
            .filter { $0.start < range.upperBound && $0.end > range.lowerBound }
    }
}
