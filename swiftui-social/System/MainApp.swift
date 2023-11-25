//
//  MainApp.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2023/10/07.
//

import SwiftUI

@main
struct MainApp: App {
    private let appEnvironment: AppEnvironment = AppEnvironment.bootstrap()

    var body: some Scene {
        WindowGroup {
            LoginView().inject(appEnvironment.container)
        }
    }
}
