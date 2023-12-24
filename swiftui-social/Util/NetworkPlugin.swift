//
//  NetworkPlugin.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2023/12/02.
//

import Foundation
import Moya

final class NetworkPlugin: PluginType {
    static let shared = NetworkPlugin()

    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case .success(let body):
            if let json = try? JSONSerialization.jsonObject(with: body.data, options: .mutableContainers) {
                //                Log.network(json)
            }
        case .failure:
            break
        }
    }
}
