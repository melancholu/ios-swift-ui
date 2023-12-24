//
//  Token.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2023/12/02.
//

struct Token: Codable {
    enum CodingKeys: String, CodingKey {
        case accessToken
        case refreshToken
        case user
    }

    let accessToken: String?
    let refreshToken: String?
    let user: User?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        accessToken = (try? container.decodeIfPresent(String.self, forKey: .accessToken))
        refreshToken = (try? container.decodeIfPresent(String.self, forKey: .refreshToken))
        user = (try? container.decodeIfPresent(User.self, forKey: .user))
    }

    init(accessToken: String?, refreshToken: String?) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.user = nil
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(accessToken, forKey: .accessToken)
        try container.encodeIfPresent(refreshToken, forKey: .refreshToken)
        try container.encodeIfPresent(user, forKey: .user)
    }
}

extension Token {
    static let stub: Self = Token(accessToken: "TEST_ACCESS_TOKEN", refreshToken: "TEST_REFRESH_TOKEN")
}
