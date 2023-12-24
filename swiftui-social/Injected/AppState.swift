//
//  AppState.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2023/11/18.
//

import SwiftUI
import Combine

struct AppState {
    var system = System()
    var isLoggedIn: Bool = CoreStorage.shared.accessToken != nil
}

extension AppState {
    struct System: Equatable {
        var isActive: Bool = false
    }
}

#if DEBUG
extension AppState {
    static var preview: AppState {
        var state = AppState()
        state.system.isActive = true
        return state
    }
}
#endif
