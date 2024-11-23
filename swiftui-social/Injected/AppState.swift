//
//  AppState.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2023/11/18.
//

import SwiftUI
import Combine

class AppState: ObservableObject, Equatable {
    static var shared = AppState()

    @Published var feedData = FeedData()
//    var isLoggedIn: Bool = CoreStorage.shared.accessToken != nil
    var isLoggedIn: Bool = true

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
