//
//  LoginView.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2023/10/07.
//

import Combine
import SwiftUI

struct LoginView: View {
    @Environment(\.injected) private var injected: DIContainer
    @EnvironmentObject var router: Router

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var alertTitle: String = ""
    @State private var apiResult: ApiResult = .notRequested

    var body: some View {
        VStack(spacing: 8) {
            TextField("Email", text: $email)
                .frame(height: 36)
                .textFieldStyle(.roundedBorder)
            SecureField("Password", text: $password)
                .frame(height: 36)
                .textFieldStyle(.roundedBorder)
            HStack {
                Button("SignUp") {
                    router.push(to: .signUp)
                }
                Spacer()
                Button("Log in") {
                    login()
                }
            }.padding([.leading, .trailing], 8)
            Spacer()
        }
        .padding(.top, 160)
        .padding([.leading, .trailing], 16)
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
            } else {
                alertTitle = ""
            }
        }
    }
}

private extension LoginView {
    func login() {
        guard case email.isEmpty = false else {
            alertTitle = "Please enter email"
            return
        }

        guard case password.isEmpty = false else {
            alertTitle = "Please enter password"
            return
        }

        injected.interactors.authInteractor.login(email: email, password: password, result: $apiResult)
    }
}

// #Preview {
//    LoginView()
// }
