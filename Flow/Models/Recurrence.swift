import Foundation

struct Recurrence: Codable, Hashable {
    var frequency: Calendar.RecurrenceRule.Frequency
    var interval = 1
    var weekdays: [Locale.Weekday] = []
    var end: Date?

    func rule(calendar: Calendar) -> Calendar.RecurrenceRule {
        Calendar.RecurrenceRule(
            calendar: calendar,
            frequency: frequency,
            interval: interval,
            end: end.map { .afterDate($0) } ?? .never,
            weekdays: weekdays.map { .every($0) }
        )
    }
}
