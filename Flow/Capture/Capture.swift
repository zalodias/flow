import Foundation

struct Capture {
    var title: String
    var date: Date?
    var duration: TimeInterval?

    init(_ text: String) {
        let match = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.date.rawValue)
            .firstMatch(in: text, range: NSRange(text.startIndex..., in: text))

        title = (match.flatMap { Range($0.range, in: text) }.map { text.replacingCharacters(in: $0, with: "") } ?? text)
            .split(separator: " ")
            .joined(separator: " ")
        date = match?.date
        duration = match.flatMap { $0.duration > 0 ? $0.duration : nil }
    }
}
