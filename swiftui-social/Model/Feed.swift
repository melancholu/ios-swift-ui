//
//  Feed.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2023/12/31.
//

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
