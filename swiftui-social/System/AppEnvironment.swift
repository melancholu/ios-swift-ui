//
//  AppEnvironment.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2023/11/25.
//

struct AppEnvironment {
    let container: DIContainer
}

extension AppEnvironment {

    static func bootstrap() -> AppEnvironment {
        let appState = Store<AppState>(AppState())
        let interactors = configuredInteractors(appState: appState)
        let diContainer = DIContainer(appState: appState, interactors: interactors)

        return AppEnvironment(container: diContainer)
    }

    private static func configuredInteractors(appState: Store<AppState>) -> DIContainer.Interactors {

        return .init()
    }
}
