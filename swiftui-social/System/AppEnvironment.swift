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
        let authRepository = configuredAuthRepository()
        let userRepository = configuredUserRepository()
        let interactors = configuredInteractors(appState: appState, authRepository: authRepository, userRepository: userRepository)
        let diContainer = DIContainer(appState: appState, interactors: interactors)

        return AppEnvironment(container: diContainer)
    }

    private static func configuredAuthRepository() -> AuthRepository {
        return AuthRepository()
    }

    private static func configuredUserRepository() -> UserRepository {
        return UserRepository()
    }

    private static func configuredInteractors(appState: Store<AppState>, authRepository: AuthRepository, userRepository: UserRepository) -> DIContainer.Interactors {
        let authInteractor = DefaultAuthInteractor(authRepository: authRepository)
        let userInteractor = DefaultUserInteractor(userRepository: userRepository)

        return .init(authInteractor: authInteractor, userInteractor: userInteractor)
    }
}
