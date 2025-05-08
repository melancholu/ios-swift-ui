//
//  Feed.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2023/12/31.
//

import Foundation

struct Feed: Codable, Equatable {
    enum CodingKeys: String, CodingKey {
        case uuid
        case user
        case content
        case created
    }

    let uuid: String?
    let user: User?
    let content: String?
    let created: String?

    init(content: String) {
        self.uuid = nil
        self.user = nil
        self.content = content
        self.created = nil
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        uuid = (try? container.decodeIfPresent(String.self, forKey: .uuid))
        user = (try? container.decodeIfPresent(User.self, forKey: .user))
        content = (try? container.decodeIfPresent(String.self, forKey: .content))
        created = (try? container.decodeIfPresent(String.self, forKey: .created))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(uuid, forKey: .uuid)
        try container.encodeIfPresent(user, forKey: .user)
        try container.encodeIfPresent(content, forKey: .content)
        try container.encodeIfPresent(created, forKey: .created)
    }

    static func == (lhs: Feed, rhs: Feed) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}

extension Feed {
    static let stub: Self = Feed(content: "TEST CONTENT")
}

extension Feed: Identifiable {
    var id: String { uuid ?? String(Int.random(in: 1..<10000)) }
}

extension Feed {
    func readableDate() -> String {
        let inputFormatter = ISO8601DateFormatter()
        inputFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        if let dateString = created, let date = inputFormatter.date(from: dateString) {
            let now = Date()
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date, to: now)

            if let seconds = components.second,
               components.year == 0,
               components.month == 0,
               components.day == 0,
               components.hour == 0,
               components.minute == 0,
               seconds < 60 {
                return "just now"
            }

            if let minutes = components.minute,
               components.year == 0,
               components.month == 0,
               components.day == 0,
               components.hour == 0,
               minutes < 60 {
                return "\(minutes)m ago"
            }

            if let hours = components.hour,
               components.year == 0,
               components.month == 0,
               components.day == 0,
               hours < 24 {
                return "\(hours)h ago"
            }

            if calendar.isDateInYesterday(date) {
                return "yesterday"
            }

            if calendar.isDate(date, equalTo: now, toGranularity: .year) {
                let formatter = DateFormatter()
                formatter.dateFormat = "MMM d"
                return formatter.string(from: date)
            }

            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d, yyyy"
            return formatter.string(from: date)
        }

        return "-"
    }
}
