//
//  UserInteractor.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2023/12/16.
//

import Foundation
import Combine

protocol UserInteractor {
    func getMe() -> AnyPublisher<User, Error>
    func getUser(_ uuid: String) -> AnyPublisher<User, Error>
    func getUsers(_ page: Int) -> AnyPublisher<Pagination<[User]>, Error>
    func signUp(user: User) -> AnyPublisher<User, Error>
}

struct DefaultUserInteractor: UserInteractor {
    private let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
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

    func signUp(user: User) -> AnyPublisher<User, Error> {
        return userRepository.signUp(user: user)
    }
}

struct StubUserInteractor: UserInteractor {
    func getMe() -> AnyPublisher<User, Error> {
        Just(User.stub).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    func getUser(_ uuid: String) -> AnyPublisher<User, Error> {
        Just(User.stub).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    func getUsers(_ page: Int) -> AnyPublisher<Pagination<[User]>, Error> {
        Just(Pagination.usersStub).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    func signUp(user: User) -> AnyPublisher<User, Error> {
        Just(User.stub).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}
