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
      VStack(alignment: .leading) {
          HStack {
              AsyncImage(url: URL(string: feed.user?.imageUrl ?? "")) { image in
                  image
                      .resizable()
                      .scaledToFit()
                      .frame(width: 30, height: 30)
              } placeholder: {
                  Image("icUser")
              }
              .frame(width: 30, height: 30)
              Text(feed.user?.name ?? "ANON")
                  .font(.system(size: 20))
                  .bold()
                  .foregroundColor(Color("gray900"))
              Spacer()
              Text(feed.readableDate())
                  .font(.system(size: 16))
                  .foregroundColor(Color("gray500"))
          }
          Text(feed.content ?? "")
              .font(.system(size: 16))
              .foregroundColor(Color("gray800"))
      }
  }
}

// #Preview {
//     FamilyRow(feed: Feed.stub)
// }
