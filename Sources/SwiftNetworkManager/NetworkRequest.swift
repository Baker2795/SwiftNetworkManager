//
//  NetworkRequest.swift
//
//  Created by John Baker on 9/10/23.
//

import Foundation

public struct NetworkRequest<ResponseType: NetworkResponse> {
    let method: HTTPMethod
    let url: URL
    var headers: [String: String]?
    var body: Data?
}

public extension NetworkRequest {
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }
}
