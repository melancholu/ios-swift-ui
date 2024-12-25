//
//  MainApp.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2023/10/07.
//

import SwiftUI

@main
struct MainApp: App {
    @StateObject private var mainRouter = Router()
    @StateObject private var authRouter = Router()
    @StateObject private var appEnvironment: AppEnvironment = AppEnvironment.bootstrap()
    @StateObject private var appState: AppState = AppState.shared

    var body: some Scene {
        WindowGroup {
            Group {
                if appEnvironment.appState.isLoggedIn {
                    NavigationStack(path: $mainRouter.path) {
                        MainTabView()
                            .navigationDestination(for: Router.MainDestination.self) { destination in
                                switch destination {
                                case .createFeed:
                                    CreateFeedView()
                                case .feedList:
                                    FeedListView(feedData: appEnvironment.appState.feedData)
                                }
                            }
                    }
                    .environmentObject(mainRouter)
                } else {
                    NavigationStack(path: $authRouter.path) {
                        LoginView()
                            .navigationDestination(for: Router.AuthDestination.self) { destination in
                                switch destination {
                                case .signUp:
                                    SignUpView()
                                }
                            }
                    }
                    .environmentObject(authRouter)
                }
            }
            .environmentObject(appEnvironment.appState)
            .environment(\.injected, appEnvironment.container)
            .animation(.easeInOut, value: appEnvironment.appState.isLoggedIn)
        }
    }
}
