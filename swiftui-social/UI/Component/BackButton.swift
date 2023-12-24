//
//  BackButton.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2023/10/08.
//

import SwiftUI

struct BackButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "arrow.backward.circle.fill")
        }
        .symbolVariant(.circle.fill)
        .font(.title)
    }
}
