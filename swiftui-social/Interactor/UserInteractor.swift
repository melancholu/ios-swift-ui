//
//  UserInteractor.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2023/12/16.
//

import Combine
import Foundation
import SwiftUI

protocol UserInteractor {
    func getMe() -> AnyPublisher<User, Error>
    func getUser(_ uuid: String) -> AnyPublisher<User, Error>
    func getUsers(_ page: Int) -> AnyPublisher<Pagination<[User]>, Error>
    func signUp(name: String, email: String, password: String, result: Binding<ApiResult>)
}

final class DefaultUserInteractor: UserInteractor {
    private let userRepository: UserRepositoryProtocol
    private var subscriptions: Set<AnyCancellable>

    init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
        self.subscriptions = Set<AnyCancellable>()
    }

    func getMe() -> AnyPublisher<User, Error> {
        return userRepository.getMe()
    }

    func getUser(_ uuid: String) -> AnyPublisher<User, Error> {
        return userRepository.getUser(uuid)
    }

    func getUsers(_ page: Int) -> AnyPublisher<Pagination<[User]>, Error> {
        return userRepository.getUsers(page)
    }

    func signUp(name: String, email: String, password: String, result: Binding<ApiResult>) {
        let user = User(name: name, email: email, password: password)

        userRepository.signUp(user: user).sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                result.wrappedValue = .success
            case .failure(let error):
                result.wrappedValue = .failed(error)
            }
        }, receiveValue: { _ in
        }).store(in: &subscriptions)
    }
}

final class StubUserInteractor: UserInteractor {
    func getMe() -> AnyPublisher<User, Error> {
        return Just(User.stub).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    func getUser(_ uuid: String) -> AnyPublisher<User, Error> {
        return Just(User.stub).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    func getUsers(_ page: Int) -> AnyPublisher<Pagination<[User]>, Error> {
        return Just(Pagination.usersStub).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    func signUp(name: String, email: String, password: String, result: Binding<ApiResult>) {}
}
