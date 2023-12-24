//
//  LoginView.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2023/10/07.
//

import SwiftUI
import Combine

struct LoginView: View {
    @Environment(\.injected) private var injected: DIContainer

    @State var email: String = ""
    @State var password: String = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 8) {
                TextField("Email", text: $email)
                    .frame(height: 36)
                    .textFieldStyle(.roundedBorder)
                SecureField("Password", text: $password)
                    .frame(height: 36)
                    .textFieldStyle(.roundedBorder)
                HStack {
                    NavigationLink("SignUp", destination: SignUpView())
                    Spacer()
                    Button("Log in") {
                        login()
                    }
                }.padding([.leading, .trailing], 8)
                Spacer()
            }
            .padding(.top, 160)
            .padding([.leading, .trailing], 16)
        }
    }
}

private extension LoginView {
    func login() {
        var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()

        injected.interactors.authInteractor.login(email: email, password: password).sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                break
            }
        }, receiveValue: { _ in
        }).store(in: &subscriptions)
    }
}

// #Preview {
//    LoginView()
// }
