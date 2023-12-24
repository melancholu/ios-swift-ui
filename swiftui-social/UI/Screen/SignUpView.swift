//
//  SignUpView.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2023/10/07.
//

import SwiftUI
import Combine

struct SignUpView: View {
    @Environment(\.injected) private var injected: DIContainer
    @Environment(\.presentationMode) var presentation

    @State var name: String = ""
    @State var email: String = ""
    @State var password: String = ""

    var body: some View {
        VStack(spacing: 8) {
            TextField("Name", text: $name)
                .frame(height: 36)
                .textFieldStyle(.roundedBorder)
            TextField("Email", text: $email)
                .frame(height: 36)
                .textFieldStyle(.roundedBorder)
            SecureField("Password", text: $password)
                .frame(height: 36)
                .textFieldStyle(.roundedBorder)
            Button(action: {
                signUp()
            }, label: {
                Text("Sign Up").frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 36)
            }).buttonStyle(PrimaryButtonStyle())
        }.padding(.top, 160)
        .padding([.leading, .trailing], 16)
        .modifier(BackButtonModifier())
        Spacer()
    }
}

private extension SignUpView {

    func signUp() {
        guard case name.isEmpty = false else {
            //            showToast(message: "Enter name")
            return
        }
        guard case email.isEmpty = false else {
            //            showToast(message: "Enter email")
            return
        }
        guard case password.isEmpty = false else {
            //            showToast(message: "Enter password")
            return
        }

        let user = User(name: name, email: email, password: password)
        var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()

        injected.interactors.userInteractor.signUp(user: user).sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                self.presentation.wrappedValue.dismiss()
            case .failure(let error):
                break
            }
        }, receiveValue: { _ in
        }).store(in: &subscriptions)
    }
}

// #Preview {
//    SignUpView()
// }
