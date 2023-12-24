//
//  User.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2023/12/02.
//

struct User: Codable {
    enum CodingKeys: String, CodingKey {
        case uuid
        case name
        case email
        case password
        case created
        case imageUrl
    }

    let uuid: String?
    let name: String?
    let email: String?
    let password: String?
    let created: String?
    let imageUrl: String?

    init(name: String?, email: String?, password: String?) {
        self.uuid = nil
        self.name = name
        self.email = email
        self.password = password
        self.created = nil
        self.imageUrl = nil
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        uuid = (try? container.decodeIfPresent(String.self, forKey: .uuid))
        name = (try? container.decodeIfPresent(String.self, forKey: .name))
        email = (try? container.decodeIfPresent(String.self, forKey: .email))
        password = (try? container.decodeIfPresent(String.self, forKey: .password))
        created = (try? container.decodeIfPresent(String.self, forKey: .created))
        imageUrl = (try? container.decodeIfPresent(String.self, forKey: .imageUrl))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(uuid, forKey: .uuid)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(email, forKey: .email)
        try container.encodeIfPresent(password, forKey: .password)
        try container.encodeIfPresent(created, forKey: .created)
        try container.encodeIfPresent(imageUrl, forKey: .imageUrl)
    }
}

extension User {
    static let stub: Self = User(name: "TEST_NAME", email: "TEST@gmail.com", password: "TEST_PASSWORD")
}
