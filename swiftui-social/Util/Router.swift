//
//  Router.swift
//  swiftui-social
//
//  Created by song dong hyeok on 11/23/24.
//

import Foundation
import SwiftUI

final class Router: ObservableObject {
    public enum AuthDestination: Codable, Hashable {
        case signUp
    }

    public enum MainDestination: Codable, Hashable {
        case createFeed
        case feedList
    }

    @Published var path = NavigationPath()

    func push(to destination: AuthDestination) {
        path.append(destination)
    }

    func push(to destination: MainDestination) {
        path.append(destination)
    }

    func pop() {
        path.removeLast()
    }

    func popToLoot() {
        path.removeLast(path.count)
    }
}
