//
//  View.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2023/11/25.
//

import SwiftUI

extension View {
    func inject(_ appState: AppState, _ container: DIContainer) -> some View {
        return self
            //            .modifier(RootViewAppearance())
            .environment(\.injected, container)
            .environmentObject(appState)
    }
}
