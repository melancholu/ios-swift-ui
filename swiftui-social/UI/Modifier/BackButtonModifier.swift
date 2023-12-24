//
//  BackButtonModifier.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2023/10/08.
//

import SwiftUI

struct BackButtonModifier: ViewModifier {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    BackButton {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
    }
}
