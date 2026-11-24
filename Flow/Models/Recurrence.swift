import Foundation

struct Recurrence: Codable, Hashable {
    var frequency: Calendar.RecurrenceRule.Frequency
    var interval = 1
    var days: [Locale.Weekday] = []
    var end: Date?
    var skip: Set<Date> = []

    func rule(calendar: Calendar) -> Calendar.RecurrenceRule {
        Calendar.RecurrenceRule(
            calendar: calendar,
            frequency: frequency,
            interval: interval,
            end: end.map { .afterDate($0) } ?? .never,
            weekdays: days.map { .every($0) }
        )
    }
}
