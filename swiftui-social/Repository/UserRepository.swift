//
//  UserRepository.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2023/12/16.
//

import Foundation
import Moya
import Combine

protocol UserRepositoryProtocol {
    func getMe() -> AnyPublisher<User, Error>
    func getUser(_ uuid: String) -> AnyPublisher<User, Error>
    func getUsers(_ page: Int) -> AnyPublisher<Pagination<[User]>, Error>
    func signUp(user: User) -> AnyPublisher<User, Error>
}

final class UserRepository: BaseRepository<UserAPI>, UserRepositoryProtocol {
    func getMe() -> AnyPublisher<User, Error> {
        return provider.requestPublisher(.getMe).tryMap { response in
            let decodedData = try response.map(User.self)

            return decodedData
        }
        .mapError { error in
            return error
        }
        .eraseToAnyPublisher()
    }

    func getUser(_ uuid: String) -> AnyPublisher<User, Error> {
        return provider.requestPublisher(.getUser(uuid: uuid)).tryMap { response in
            let decodedData = try response.map(User.self)

            return decodedData
        }
        .mapError { error in
            return error
        }
        .eraseToAnyPublisher()
    }

    func getUsers(_ page: Int = 1) -> AnyPublisher<Pagination<[User]>, Error> {
        return provider.requestPublisher(.getUsers(page: page)).tryMap { response in
            let decodedData = try response.map(Pagination<[User]>.self)

            return decodedData
        }
        .mapError { error in
            return error
        }
        .eraseToAnyPublisher()
    }

    func signUp(user: User) -> AnyPublisher<User, Error> {
        return provider.requestPublisher(.signUp(user: user)).tryMap { response in
            let decodedData = try response.map(User.self)

            return decodedData
        }
        .mapError { error in
            return error
        }
        .eraseToAnyPublisher()
    }
}
