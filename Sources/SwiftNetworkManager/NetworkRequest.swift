//
//  NetworkRequest.swift
//
//  Created by John Baker on 9/10/23.
//

import Foundation

public struct NetworkRequest<ResponseType: NetworkResponse> {
    public let method: HTTPMethod
    public let url: URL
    public var headers: [String: String]?
    public var body: Data?
}

public extension NetworkRequest {
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }
}
