//
//  PrimaryButtonStyle.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2023/10/07.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    let labelColor = Color.white
    let backgroundColor = Color.primary

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(labelColor)
            .background(backgroundColor)
            .cornerRadius(8)
    }
}
