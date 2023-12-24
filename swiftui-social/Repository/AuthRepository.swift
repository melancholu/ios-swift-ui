//
//  AuthRepository.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2023/12/02.
//

import Foundation
import Combine
import CombineMoya

protocol AuthRepositoryProtocol {
    func login(user: User) -> AnyPublisher<Token, Error>
    func logout() -> AnyPublisher<Void, Error>
    func refresh() -> AnyPublisher<Void, Error>
}

final class AuthRepository: BaseRepository<AuthAPI>, AuthRepositoryProtocol {
    private let coreStorage: CoreStorage = CoreStorage.shared

    func login(user: User) -> AnyPublisher<Token, Error> {
        return provider.requestPublisher(.login(user: user)).tryMap { response in
            let decodedData = try response.map(Token.self)

            return decodedData
        }
        .mapError { error in
            return error
        }
        .eraseToAnyPublisher()
    }

    func logout() -> AnyPublisher<Void, Error> {
        return provider.requestPublisher(.logout).tryMap { _ in
            self.coreStorage.setToken(nil)
            self.coreStorage.setUser(nil)
        }
        .mapError { error in
            return error
        }
        .eraseToAnyPublisher()
    }

    func refresh() -> AnyPublisher<Void, Error> {
        return provider.requestPublisher(.refresh).tryMap { response in
            let decodedData = try response.map(Token.self)

            self.coreStorage.setToken(decodedData)
        }
        .mapError { error in
            return error
        }
        .eraseToAnyPublisher()
    }
}
