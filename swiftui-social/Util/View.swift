//
//  View.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2023/11/25.
//

import SwiftUI

extension View {
    func inject(_ appState: AppState,
                _ interactors: DIContainer.Interactors) -> some View {
        let container = DIContainer(appState: .init(appState),
                                    interactors: interactors)
        return inject(container)
    }

    func inject(_ container: DIContainer) -> some View {
        return self
            //            .modifier(RootViewAppearance())
            .environment(\.injected, container)
    }
}
