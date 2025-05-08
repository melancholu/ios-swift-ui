//
//  FeedListView.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2023/12/31.
//

import SwiftUI
import Combine

struct FeedListView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.injected) private var injected: DIContainer
    @EnvironmentObject var router: Router
    @ObservedObject var feedData: AppState.FeedData

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            List(appState.feedData.feeds) { feed in
              FamilyRow(feed: feed)
                .onAppear {
                    if feed == appState.feedData.feeds.last {
                        loadMore()
                    }
                }
            }
            if appState.feedData.isLoading == .loading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            Button {
                router.push(to: .createFeed)
            } label: {
                Image(systemName: "plus")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Circle())
            }
            .padding(16)
        }
        .onAppear {
            if appState.feedData.feeds.isEmpty {
                loadMore()
            }
        }
    }
}

private extension FeedListView {
    func loadMore() {
        DispatchQueue.main.async {
            injected.interactors.feedInteractor.getFeeds()
        }
    }
}
