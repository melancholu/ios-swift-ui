//
//  AuthInteractor.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2023/12/02.
//

import Combine
import Foundation
import SwiftUI

protocol AuthInteractor {
    func login(email: String, password: String, result: Binding<ApiResult>)
    func logout()
    func refresh() -> AnyPublisher<Void, Error>
}

final class DefaultAuthInteractor: AuthInteractor {
    private let authRepository: AuthRepositoryProtocol
    private var subscriptions: Set<AnyCancellable>

    init(authRepository: AuthRepositoryProtocol) {
        self.authRepository = authRepository
        self.subscriptions = Set<AnyCancellable>()
    }

    func login(email: String, password: String, result: Binding<ApiResult>) {
        let user = User(name: nil, email: email, password: password)

        authRepository.login(user: user).sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                result.wrappedValue = .success
            case .failure:
                result.wrappedValue = .failed(StringError(message: "Please check email or password"))
            }
        }, receiveValue: { token in
            CoreStorage.shared.setToken(token)
        }).store(in: &subscriptions)
    }

    func logout() {
        authRepository.logout().sink(receiveCompletion: { _ in
        }, receiveValue: { _ in
            CoreStorage.shared.setToken(nil)
            CoreStorage.shared.setUser(nil)
        }).store(in: &subscriptions)
    }

    func refresh() -> AnyPublisher<Void, Error> {
        return authRepository.refresh()
    }
}

final class StubAuthInteractor: AuthInteractor {
    func login(email: String, password: String, result: Binding<ApiResult>) {}

    func logout() {}

    func refresh() -> AnyPublisher<Void, Error> {
        return Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}
