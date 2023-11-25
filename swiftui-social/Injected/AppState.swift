//
//  AppState.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2023/11/18.
//

import SwiftUI
import Combine

struct AppState: Equatable {
    var system = System()
}

extension AppState {
    struct System: Equatable {
        var isActive: Bool = false
        var keyboardHeight: CGFloat = 0
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
