//
//  Loadable.swift
//  swiftui-social
//
//  Created by song dong hyeok on 12/10/24.
//

import Combine
import Foundation
import SwiftUI

typealias LoadableSubject<Value> = Binding<Loadable<Value>>

enum Loadable<T> {
    case notRequested
    case isLoading(last: T?, cancelBag: Set<AnyCancellable>)
    case loaded(T)
    case failed(Error)

    var value: T? {
        switch self {
        case let .loaded(value): return value
        case let .isLoading(last, _): return last
        default: return nil
        }
    }
    var error: Error? {
        switch self {
        case let .failed(error): return error
        default: return nil
        }
    }
}

enum ApiResult: Equatable {
    case success
    case failed(Error)
    case notRequested

    static func == (lhs: ApiResult, rhs: ApiResult) -> Bool {
        switch (lhs, rhs) {
        case (.success, .success):
            return true
        case (.notRequested, .notRequested):
            return true
        case (.failed(let lhsError), .failed(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}

struct StringError: Error {
    let message: String
}
