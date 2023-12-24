//
//  UserAPI.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2023/12/16.
//

import Foundation
import Moya

enum UserAPI {
    case getMe
    case getUser(uuid: String)
    case getUsers(page: Int)
    case signUp(user: User)
}

extension UserAPI: BaseAPI {
    var path: String {
        switch self {
        case .getMe: return "/user/me"
        case .getUser: return "/user"
        case .getUsers: return "/user"
        case .signUp: return "/user"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getMe: return .get
        case .getUser: return .get
        case .getUsers: return .get
        case .signUp: return .post
        }
    }

    var task: Task {
        switch self {
        case .getMe:
            return .requestPlain
        case let .getUser(uuid):
            return .requestParameters(parameters: ["uuid": uuid], encoding: URLEncoding.queryString)
        case let .getUsers(page):
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding.queryString)
        case let .signUp(user):
            return .requestJSONEncodable(user)
        }
    }

    var sampleData: Data {
        switch self {
        case .getMe, .getUser, .signUp:
            return Data(
                """
                {
                    "uuid": "TEST_UUID",
                    "name": "TEST_NAME",
                    "email": "TESTEMAIL@gmail.com",
                    "password": "TEST_PASSWORD",
                    "created": "2023-10-14T12:40:38.198Z"
                }
                """.utf8)
        case .getUsers:
            return Data(
                """
                {
                    "data": [{
                            "uuid": "TEST_UUID",
                            "name": "TEST_NAME",
                            "email": "TESTEMAIL@gmail.com",
                            "password": "TEST_PASSWORD",
                            "created": "2023-10-14T12:40:38.198Z"
                        }
                    }, {
                            "uuid": "TEST_UUID",
                            "name": "TEST_NAME",
                            "email": "TESTEMAIL@gmail.com",
                            "password": "TEST_PASSWORD",
                            "created": "2023-10-14T12:40:38.198Z"
                        }
                    }],
                    "meta": {
                        "cur_page": 1,
                        "next_page": 2,
                        "page_num": 5,
                    }
                }
                """.utf8)
        }
    }
}
