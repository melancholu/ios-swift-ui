//
//  InteractorsContainer.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2023/11/18.
//

extension DIContainer {
    struct Interactors {
        let authInteractor: AuthInteractor
        let feedInteractor: FeedInteractor
        let userInteractor: UserInteractor

        init(authInteractor: AuthInteractor,
             feedInteractor: FeedInteractor,
             userInteractor: UserInteractor) {
            self.authInteractor = authInteractor
            self.feedInteractor = feedInteractor
            self.userInteractor = userInteractor
        }

        static var stub: Self {
            .init(authInteractor: StubAuthInteractor(), feedInteractor: StubFeedInteractor(), userInteractor: StubUserInteractor())
        }
    }
}
