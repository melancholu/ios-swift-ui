//
//  AppState.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2023/11/18.
//

import Combine
import SwiftUI

final class AppState: ObservableObject, Equatable {
    static var shared = AppState()

    private var cancellable: AnyCancellable?

    @Published var feedData = FeedData()
    @Published var isLoggedIn: Bool = CoreStorage.shared.accessToken != nil

    init() {
        cancellable = CoreStorage.shared.$accessToken
            .map { $0 != nil }
            .sink { [weak self] in
                self?.isLoggedIn = $0
            }
    }

    static func == (lhs: AppState, rhs: AppState) -> Bool {
        return lhs.feedData == rhs.feedData
    }
}

extension AppState {
    class FeedData: ObservableObject, Equatable {
        @Published var feeds: [Feed] = [Feed.stub, Feed.stub, Feed.stub, Feed.stub, Feed.stub, Feed.stub, Feed.stub, Feed.stub, Feed.stub, Feed.stub, Feed.stub]
        @Published var nextPage: Int = 0
        @State var isLoading: Loading = .idle

        static func == (lhs: FeedData, rhs: FeedData) -> Bool {
            return lhs.feeds == rhs.feeds && lhs.nextPage == rhs.nextPage
        }
    }
}
