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
    @EnvironmentObject var router: Router

    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var alertTitle: String = ""
    @State private var apiResult: ApiResult = .notRequested

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

private extension SignUpView {
    func signUp() {
        guard case name.isEmpty = false else {
            alertTitle = "Please enter name"
            return
        }
        guard case email.isEmpty = false else {
            alertTitle = "Please enter email"
            return
        }
        guard case password.isEmpty = false else {
            alertTitle = "Please enter password"
            return
        }

        injected.interactors.userInteractor.signUp(name: name, email: email, password: password, result: $apiResult)
    }
}

// #Preview {
//    SignUpView()
// }
