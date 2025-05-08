//
//  FeedAPI.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2024/01/13.
//

import Foundation
import Moya

enum FeedAPI {
    case createFeed(feed: Feed)
    case getFeeds(page: Int)
}

extension FeedAPI: BaseAPI {
    var path: String {
        switch self {
        case .createFeed: return "/feed/"
        case .getFeeds: return "/feed"
        }
    }

    var method: Moya.Method {
        switch self {
        case .createFeed: return .post
        case .getFeeds: return .get
        }
    }

    var task: Task {
        switch self {
        case let .createFeed(feed):
            return .requestJSONEncodable(feed)
        case let .getFeeds(page):
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding.queryString)
        }
    }

    var sampleData: Data {
        switch self {
        case .createFeed:
            return Data(
                """
                {
                    "uuid": "1",
                    "user": {
                        "uuid": "TEST_UUID",
                        "name": "TEST_NAME",
                        "email": "TESTEMAIL@gmail.com",
                        "password": "TEST_PASSWORD",
                        "created": "2023-10-14T12:40:38.198Z"
                    },
                    "content": "TEST_CONTENT",
                    "created": "2023-10-14T12:40:38.198Z"
                }
                """.utf8
            )
        case .getFeeds:
            return Data(
                """
                {
                    "data": [{
                        "uuid": "1",
                        "user": {
                            "uuid": "TEST_UUID",
                            "name": "TEST_NAME",
                            "email": "TESTEMAIL@gmail.com",
                            "password": "TEST_PASSWORD",
                            "created": "2023-10-14T12:40:38.198Z"
                        },
                        "content": "TEST_CONTENT1",
                        "created": "2023-10-14T12:40:38.198Z"
                    }, {
                        "uuid": "2",
                        "user": {
                            "uuid": "TEST_UUID",
                            "name": "TEST_NAME",
                            "email": "TESTEMAIL@gmail.com",
                            "password": "TEST_PASSWORD",
                            "created": "2023-10-14T12:40:38.198Z"
                        },
                        "content": "TEST_CONTENT2",
                        "created": "2023-10-14T12:40:38.198Z"
                    }],
                    "meta": {
                        "cur_page": 1,
                        "next_page": 2,
                        "page_num": 5,
                    }
                }
                """.utf8
            )
        }
    }
}
