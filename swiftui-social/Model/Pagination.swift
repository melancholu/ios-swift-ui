//
//  Pagination.swift
//  swiftui-social
//
//  Created by song dong hyeok on 2023/12/16.
//

struct Pagination<T: Codable>: Codable {
    enum CodingKeys: String, CodingKey {
        case data
        case meta
    }

    let data: T
    let meta: PaginationMeta
}

struct PaginationMeta: Codable {
    enum CodingKeys: String, CodingKey {
        case curPage = "cur_page"
        case nextPage = "next_page"
        case pageNum = "page_num"
    }

    let curPage: Int
    let nextPage: Int
    let pageNum: Int
}

extension Pagination<[User]> {
    static let usersStub: Self = Pagination<[User]>(data: [User.stub], meta: PaginationMeta.stub)
}

extension PaginationMeta {
    static let stub: Self = PaginationMeta(curPage: 0, nextPage: 1, pageNum: 1)
}
