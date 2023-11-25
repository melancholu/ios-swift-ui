//
//  DependencyInjector.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2023/11/18.
//

import SwiftUI
import Combine

struct DIContainer: EnvironmentKey {

    let appState: Store<AppState>
    let interactors: Interactors

    init(appState: Store<AppState>, interactors: Interactors) {
        self.appState = appState
        self.interactors = interactors
    }

    init(appState: AppState, interactors: Interactors) {
        self.init(appState: Store<AppState>(appState), interactors: interactors)
    }

    static var defaultValue: Self { Self.default }

    private static let `default` = Self(appState: AppState(), interactors: .stub)
}

extension EnvironmentValues {
    var injected: DIContainer {
        get { self[DIContainer.self] }
        set { self[DIContainer.self] = newValue }
    }
}

#if DEBUG
extension DIContainer {
    static var preview: Self {
        .init(appState: .init(AppState.preview), interactors: .stub)
    }
}
#endif
