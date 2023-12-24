//
//  InteractorsContainer.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2023/11/18.
//

extension DIContainer {
    struct Interactors {
        let authInteractor: AuthInteractor
        let userInteractor: UserInteractor

        static var stub: Self {
            .init(authInteractor: StubAuthInteractor(), userInteractor: StubUserInteractor())
        }
    }
}
