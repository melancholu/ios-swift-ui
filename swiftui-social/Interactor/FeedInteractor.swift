//
//  FeedInteractor.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2024/01/13.
//

import Foundation
import Combine

protocol FeedInteractor {
    func getFeeds()
}

struct DefaultFeedInteractor: FeedInteractor {
    private let appState: AppState
    private let feedRepository: FeedRepository
    private var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()

    init(appState: AppState, feedRepository: FeedRepository) {
        self.appState = appState
        self.feedRepository = feedRepository
    }

    func getFeeds() {
        guard appState.feedData.isLoading != .loading else { return }

        var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()

        feedRepository.getFeeds(appState.feedData.nextPage)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    appState.feedData.isLoading = .completed
                case .failure(let error):
                    appState.feedData.isLoading = .error
                }
            }, receiveValue: { response in
                let data = response.data
                let meta = response.meta

                appState.feedData.feeds.append(contentsOf: data)
                appState.feedData.nextPage = data.count == 0 ? -1 : meta.nextPage
            }).store(in: &subscriptions)
    }
}

struct StubFeedInteractor: FeedInteractor {
    func getFeeds() {}
}
