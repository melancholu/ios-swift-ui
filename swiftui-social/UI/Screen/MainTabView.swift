//
//  MainTabView.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2023/12/31.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        TabView {
            FeedListView(feedData: appState.feedData)
                .tabItem {
                    Label("FeedList", image: "icFeed")
                }
            FeedListView(feedData: appState.feedData)
                .tabItem {
                    Label("FeedList", image: "icFeed")
                }
        }
    }
}
