//
//  Env.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2023/12/02.
//

import Foundation

enum Env {
    enum Mode: String {
        case prod = "PRODUCTION"
        case dev = "DEVELOPMENT"
        case local = "LOCAL"
    }

    enum Keys: String {
        case baseURL = "BASE_URL"
    }

    static let baseURL: String = {
        guard let baseURL = Bundle.main.infoDictionary![Keys.baseURL.rawValue] as? String else {
            fatalError("BASE URL IS NOT SET IN PLIST")
        }

        return baseURL
    }()
}
