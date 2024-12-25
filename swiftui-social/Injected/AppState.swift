//
//  AppState.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2023/11/18.
//

import Combine
import SwiftUI

final class AppState: ObservableObject {
    static var shared = AppState()

    private var cancellable: AnyCancellable?

    @Published var feedData = FeedData()
    @Published var isLoggedIn: Bool = CoreStorage.shared.accessToken != nil

    init() {
        cancellable = CoreStorage.shared.$accessToken
            .map { $0 != nil }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.isLoggedIn = $0
            }
    }
}

extension AppState {
    class FeedData: ObservableObject {
        @Published var feeds: [Feed] = []
        @Published var nextPage: Int = 1
        @Published var isLoading: Loading = .idle
    }
}
