//
//  DependencyInjector.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2023/11/18.
//

import SwiftUI
import Combine

struct DIContainer: EnvironmentKey {

    let interactors: Interactors

    static var defaultValue: Self { Self.default }

    private static let `default` = Self(interactors: .stub)
}

extension EnvironmentValues {
    var injected: DIContainer {
        get { self[DIContainer.self] }
        set { self[DIContainer.self] = newValue }
    }
}
