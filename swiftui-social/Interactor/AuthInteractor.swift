//
//  AuthInteractor.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2023/12/02.
//

import Foundation
import Combine

protocol AuthInteractor {
    func login(email: String, password: String) -> AnyPublisher<Token, Error>
    func logout() -> AnyPublisher<Void, Error>
    func refresh() -> AnyPublisher<Void, Error>
}

struct DefaultAuthInteractor: AuthInteractor {
    private let authRepository: AuthRepository

    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    func login(email: String, password: String) -> AnyPublisher<Token, Error> {
        let user = User(name: nil, email: email, password: password)

        return authRepository.login(user: user)
    }

    func logout() -> AnyPublisher<Void, Error> {
        return authRepository.logout()
    }

    func refresh() -> AnyPublisher<Void, Error> {
        return authRepository.refresh()
    }
}

struct StubAuthInteractor: AuthInteractor {
    func login(email: String, password: String) -> AnyPublisher<Token, Error> {
        Just(Token.stub).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    func logout() -> AnyPublisher<Void, Error> {
        Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    func refresh() -> AnyPublisher<Void, Error> {
        Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}
