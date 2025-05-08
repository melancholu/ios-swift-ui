//
//  AppEnvironment.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2023/11/25.
//

import Combine

class AppEnvironment: ObservableObject {
    @Published var appState: AppState
    let container: DIContainer

    init(appState: AppState, container: DIContainer) {
        self.appState = appState
        self.container = container
    }
}

extension AppEnvironment {
    static func bootstrap() -> AppEnvironment {
        let appState = AppState.shared
        let authRepository = configuredAuthRepository()
        let feedRepository = configuredFeedRepository()
        let userRepository = configuredUserRepository()
        let interactors = configuredInteractors(appState: appState, authRepository: authRepository, feedRepository: feedRepository, userRepository: userRepository)
        let diContainer = DIContainer(interactors: interactors)

        return AppEnvironment(appState: appState, container: diContainer)
    }

    private static func configuredAuthRepository() -> AuthRepository {
        return AuthRepository(.prod)
    }

    private static func configuredFeedRepository() -> FeedRepository {
        return FeedRepository()
    }

    private static func configuredUserRepository() -> UserRepository {
        return UserRepository()
    }

    private static func configuredInteractors(appState: AppState, authRepository: AuthRepository, feedRepository: FeedRepository, userRepository: UserRepository) -> DIContainer.Interactors {
        let authInteractor = DefaultAuthInteractor(authRepository: authRepository)
        let feedInteractor = DefaultFeedInteractor(appState: appState, feedRepository: feedRepository)
        let userInteractor = DefaultUserInteractor(userRepository: userRepository)

        return .init(authInteractor: authInteractor, feedInteractor: feedInteractor, userInteractor: userInteractor)
    }
}
