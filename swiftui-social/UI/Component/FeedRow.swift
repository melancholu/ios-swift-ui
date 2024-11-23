//
//  FeedRow.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2023/12/31.
//

import SwiftUI

struct FamilyRow: View {
  var feed: Feed

  var body: some View {
      VStack {
          HStack {
              AsyncImage(url: URL(string: feed.user?.imageUrl ?? "")) { image in
              image.image?.resizable().aspectRatio(contentMode: .fit)}
              .frame(width: 30, height: 30)

              Text(feed.user?.name ?? "TEMP")
              Text(feed.created ?? "Created")
          }
          Text(feed.content ?? "")
      }
  }
}

 #Preview {
     FamilyRow(feed: Feed.stub)
 }
