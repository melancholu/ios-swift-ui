//
//  MainApp.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2023/10/07.
//

import SwiftUI

@main
struct MainApp: App {
    @ObservedObject private var router = Router()

    private let appEnvironment: AppEnvironment = AppEnvironment.bootstrap()

    var body: some Scene {
        WindowGroup {
            if appEnvironment.appState.isLoggedIn {
                NavigationStack(path: $router.path) {
                    MainTabView().inject(appEnvironment.appState, appEnvironment.container)
                        .navigationDestination(for: Router.MainDestination.self) { destination in
                            switch destination {
                            case .createFeed:
                                CreateFeedView()
                            case .feedList:
                                FeedListView()
                            }
                        }
                }.environmentObject(router)
            } else {
                NavigationStack(path: $router.path) {
                    LoginView().inject(appEnvironment.appState, appEnvironment.container)
                        .navigationDestination(for: Router.AuthDestination.self) { destination in
                            switch destination {
                            case .signUp:
                                SignUpView()
                            }
                        }
                }.environmentObject(router)
            }
        }
    }
}
