//
//  UserAPI.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2023/12/02.
//

import Foundation
import Moya

enum AuthAPI {
    case login(user: User)
    case logout
    case refresh
}

extension AuthAPI: BaseAPI {
    var baseURL: URL {
        URL(string: Env.baseURL)!
    }

    var path: String {
        switch self {
        case .login: return "/auth/login"
        case .logout: return "/auth/logout"
        case .refresh: return "/auth/refresh"
        }
    }

    var method: Moya.Method {
        switch self {
        case .login: return .post
        case .logout: return .post
        case .refresh: return .post
        }
    }

    var task: Task {
        switch self {
        case let .login(user):
            return .requestJSONEncodable(user)
        case .logout:
            return .requestPlain
        case .refresh:
            return .requestPlain
        }
    }

    var sampleData: Data {
        switch self {
        case .login, .refresh:
            return Data(
                """
                {
                    "accessToken": "TEST_ACCESS_TOKEN",
                    "refreshToken": "TEST_REFRESH_TOKEN",
                    "user": {
                        "uuid": "TEST_UUID",
                        "name": "TEST_NAME",
                        "email": "TESTEMAIL@gmail.com",
                        "password": "TEST_PASSWORD",
                        "created": "2023-10-14T12:40:38.198Z"
                    }
                }
                """.utf8)
        default:
            return Data()
        }
    }
}
