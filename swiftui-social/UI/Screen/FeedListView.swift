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

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            List(appState.feedData.feeds) { feed in
              FamilyRow(feed: feed)
                .onAppear {
                    loadMore()
                }
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
    }
}

private extension FeedListView {
    func loadMore() {
        injected.interactors.feedInteractor.getFeeds()
    }
}
