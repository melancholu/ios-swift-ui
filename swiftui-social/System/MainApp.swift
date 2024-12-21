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

    @State private var isLoggedIn = false
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
                                    FeedListView()
                                }
                            }
                    }
                    .environmentObject(mainRouter)
                    .environment(\.injected, appEnvironment.container)
                    .environmentObject(appEnvironment.appState)
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
                    .environment(\.injected, appEnvironment.container)
                    .environmentObject(appEnvironment.appState)
                }
            }
            .environmentObject(appEnvironment)
            .animation(.easeInOut, value: appEnvironment.appState.isLoggedIn)
        }
    }
}
