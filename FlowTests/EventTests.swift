import Foundation
import SwiftData
import Testing
@testable import Flow

struct EventTests {
    let calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = .gmt
        return calendar
    }()

    func date(_ month: Int, _ day: Int, _ hour: Int = 0, _ minute: Int = 0) -> Date {
        calendar.date(from: DateComponents(year: 2026, month: month, day: day, hour: hour, minute: minute))!
    }

    func starts(of event: Event, from start: Date, to end: Date) -> [Date] {
        event.occurrences(in: start..<end, calendar: calendar).map(\.start)
    }

    @Test func singleEventOccursOnlyInsideItsRange() {
        let event = Event(title: "Northwind kickoff", start: date(11, 23, 10), end: date(11, 23, 11))

        #expect(starts(of: event, from: date(11, 23), to: date(11, 24)) == [date(11, 23, 10)])
        #expect(starts(of: event, from: date(11, 24), to: date(11, 25)).isEmpty)
    }

    @Test func dailyEventRepeatsEveryInterval() {
        let event = Event(
            title: "Run 5k",
            start: date(11, 23, 7, 30),
            end: date(11, 23, 8, 15),
            recurrence: Recurrence(frequency: .daily, interval: 2)
        )

        #expect(starts(of: event, from: date(11, 23), to: date(11, 30)) == [23, 25, 27, 29].map { date(11, $0, 7, 30) })
    }

    @Test func weeklyEventRepeatsOnChosenWeekdays() {
        let event = Event(
            title: "Padel",
            start: date(11, 23, 19, 30),
            end: date(11, 23, 21),
            recurrence: Recurrence(frequency: .weekly, weekdays: [.monday, .thursday])
        )

        #expect(
            starts(of: event, from: date(11, 23), to: date(12, 7))
                == [date(11, 23, 19, 30), date(11, 26, 19, 30), date(11, 30, 19, 30), date(12, 3, 19, 30)]
        )
    }

    @Test func monthlyEventRepeatsOnTheSameDay() {
        let event = Event(
            title: "Pay IRS instalment",
            start: date(11, 21, 9),
            end: date(11, 21, 10),
            recurrence: Recurrence(frequency: .monthly)
        )

        #expect(
            starts(of: event, from: date(11, 1), to: calendar.date(from: DateComponents(year: 2027, month: 2, day: 1))!)
                == [date(11, 21, 9), date(12, 21, 9), calendar.date(from: DateComponents(year: 2027, month: 1, day: 21, hour: 9))!]
        )
    }

    @Test func seriesStopsAtItsEnd() {
        let event = Event(
            title: "Run 5k",
            start: date(11, 23, 7, 30),
            end: date(11, 23, 8, 15),
            recurrence: Recurrence(frequency: .daily, end: date(11, 25, 12))
        )

        #expect(starts(of: event, from: date(11, 23), to: date(12, 7)) == [23, 24, 25].map { date(11, $0, 7, 30) })
    }

    @Test func skippedOccurrenceIsLeftOut() {
        let event = Event(
            title: "Run 5k",
            start: date(11, 23, 7, 30),
            end: date(11, 23, 8, 15),
            recurrence: Recurrence(frequency: .daily)
        )
        event.skippedDates = [date(11, 24, 7, 30)]

        #expect(starts(of: event, from: date(11, 23), to: date(11, 26)) == [date(11, 23, 7, 30), date(11, 25, 7, 30)])
    }

    @Test func recurrenceSurvivesASaveAndFetch() throws {
        let context = ModelContext(try ModelContainer(for: Event.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true)))
        let recurrence = Recurrence(frequency: .weekly, interval: 2, weekdays: [.monday, .thursday], end: date(12, 31))
        context.insert(Event(title: "Padel", start: date(11, 23, 19, 30), end: date(11, 23, 21), recurrence: recurrence))
        try context.save()

        #expect(try context.fetch(FetchDescriptor<Event>()).first?.recurrence == recurrence)
    }

    @Test func occurrenceStartingBeforeTheRangeStillOverlapsIt() {
        let event = Event(
            title: "Night shift",
            start: date(11, 20, 23),
            end: date(11, 21, 1),
            recurrence: Recurrence(frequency: .daily)
        )

        #expect(starts(of: event, from: date(11, 23), to: date(11, 24)) == [date(11, 22, 23), date(11, 23, 23)])
    }
}
