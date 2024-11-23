//
//  MainTabView.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2023/12/31.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            FeedListView()
                .tabItem {
                    Label("FeedList", image: "icFeed")
                }
            FeedListView()
                .tabItem {
                    Label("FeedList", image: "icFeed")
                }
        }
    }
}
