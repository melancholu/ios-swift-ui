//
//  FeedInteractor.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2024/01/13.
//

import Combine
import Foundation
import SwiftUI

protocol FeedInteractor {
    func getFeeds()
    func createFeeds(content: String, result: Binding<ApiResult>)
}

final class DefaultFeedInteractor: FeedInteractor {
    private let appState: AppState
    private let feedRepository: FeedRepositoryProtocol
    private var subscriptions: Set<AnyCancellable>

    init(appState: AppState, feedRepository: FeedRepositoryProtocol) {
        self.appState = appState
        self.feedRepository = feedRepository
        self.subscriptions = Set<AnyCancellable>()
    }

    func getFeeds() {
        guard appState.feedData.nextPage != -1 else { return }
        guard appState.feedData.isLoading != .loading else { return }

        appState.feedData.isLoading = .loading
        feedRepository.getFeeds(appState.feedData.nextPage)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.appState.feedData.isLoading = .completed
                case .failure:
                    self.appState.feedData.isLoading = .error
                }
            }, receiveValue: { response in
                let data = response.data
                let meta = response.meta

                self.appState.feedData.feeds.append(contentsOf: data)
                self.appState.feedData.nextPage = data.count == 0 ? -1 : meta.nextPage
            }).store(in: &subscriptions)
    }

    func createFeeds(content: String, result: Binding<ApiResult>) {
        let feed = Feed(content: content)

        feedRepository.createFeed(feed).sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                result.wrappedValue = .success
            case .failure(let error):
                result.wrappedValue = .failed(error)
            }
        }, receiveValue: { _ in
        }).store(in: &subscriptions)
    }
}

final class StubFeedInteractor: FeedInteractor {
    func getFeeds() {}
    func createFeeds(content: String, result: Binding<ApiResult>) {}
}
