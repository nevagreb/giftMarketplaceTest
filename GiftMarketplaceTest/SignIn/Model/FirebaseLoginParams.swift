//  Created by Kristina Grebneva on 05.09.2025.


import Foundation

struct FirebaseLoginParams: Codable {
    let fbIdToken: String
}

struct JSONRequest<Params: Codable>: Codable {
    var jsonrpc = "2.0"
    let method: String
    let params: Params
    let id: Int
}

struct JSONSuccess<Result: Codable>: Codable {
    let jsonrpc: String
    let result: Result
    let id: Int
}

struct JSONError: Codable, Error {
    struct RPCError: Codable, Error {
        let code: Int
        let message: String
        let data: String?
    }
    let jsonrpc: String
    let error: RPCError
    let id: Int
}

struct JSONResult: Codable {
    let accessToken: String
    let me: Me
    struct Me: Codable {
        let id: Int
        let name: String
    }
}
