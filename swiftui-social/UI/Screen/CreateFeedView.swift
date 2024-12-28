//
//  CreateFeedView.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2024/01/27.
//

import SwiftUI

struct CreateFeedView: View {
    @Environment(\.injected) private var injected: DIContainer
    @EnvironmentObject var router: Router

    @State private var content: String = ""
    @State private var alertTitle: String = ""
    @State private var apiResult: ApiResult = .notRequested

    var body: some View {
        VStack(spacing: 8) {
            TextEditor(text: $content)
                .padding()
                .border(Color.gray, width: 1)
                .frame(height: 250)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8).stroke(Color.gray)
                )
            Button(action: {
                createFeed()
            }, label: {
                Text("Post")
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 36)
            }).buttonStyle(PrimaryButtonStyle())
        }
        .padding([.top, .leading, .trailing], 16)
        .modifier(BackButtonModifier())
        .alert(alertTitle, isPresented: Binding(
            get: { alertTitle != "" },
            set: { if !$0 { alertTitle = "" } }
        )) {
            Button("ok", role: .cancel) {
                alertTitle = ""
            }
        }
        .onChange(of: apiResult) {
            if case .failed(let error) = apiResult {
                if let stringError = error as? StringError {
                    alertTitle = stringError.message
                } else {
                    alertTitle = error.localizedDescription
                }
            } else if case .success = apiResult {
                self.router.pop()
            } else {
                alertTitle = ""
            }
        }
        Spacer()
    }
}

private extension CreateFeedView {
    func createFeed() {
        guard case content.isEmpty = false else {
            alertTitle = "Please enter feed"
            return
        }

        injected.interactors.feedInteractor.createFeeds(content: content, result: $apiResult)
    }
}
// #Preview {
//    CreateFeedView()
// }
