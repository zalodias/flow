import Foundation
import Testing
@testable import Flow

struct CaptureTests {
    @Test func textWithoutDateKeepsItsTitle() {
        let capture = Capture("Buy filter for the Brita jug")

        #expect(capture.title == "Buy filter for the Brita jug")
        #expect(capture.date == nil)
    }

    @Test func dateAndTimeAreTakenOutOfTheTitle() throws {
        let capture = Capture("Padel tomorrow 19:30")
        let date = try #require(capture.date)
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: .now)!

        #expect(capture.title == "Padel")
        #expect(Calendar.current.isDate(date, inSameDayAs: tomorrow))
        #expect(Calendar.current.dateComponents([.hour, .minute], from: date) == DateComponents(hour: 19, minute: 30))
    }

    @Test func dateInTheMiddleLeavesASingleSpace() throws {
        let capture = Capture("Send invoice friday to Rui")

        #expect(capture.title == "Send invoice to Rui")
        #expect(Calendar.current.component(.weekday, from: try #require(capture.date)) == 6)
    }

    @Test func timeRangeGivesADuration() throws {
        #expect(try #require(Capture("Workshop tomorrow from 10:00 to 12:00").duration) == 2 * 60 * 60)
    }
}
