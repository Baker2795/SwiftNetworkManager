//
//  NetworkManager.swift
//
//  Created by John Baker on 9/10/23.
//

import Foundation

public enum NetworkError: Error {
    case httpError(statusCode: Int)
    case decodingError(Error)
    case other(String)
}

// MARK: - NetworkManager Class
public class NetworkManager {
    private let session: URLSession
    
    public init() {
        let configuration = URLSessionConfiguration.default
        session = URLSession(configuration: configuration)
    }
    
    public func getNetworkResponse<ResponseType: NetworkResponse>(_ request: NetworkRequest<ResponseType>) async throws -> ResponseType {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.httpBody = request.body
        
        let (data, response) = try await session.data(for: urlRequest)
        
        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            throw NetworkError.httpError(statusCode: httpResponse.statusCode)
        }
        
        do {
            let decodedResponse = try JSONDecoder().decode(ResponseType.self, from: data)
            return decodedResponse
        } catch {
            print(error)
            throw NetworkError.decodingError(error)
        }
    }
    
    public func getHTTPResponseCode<ResponseType: NetworkResponse>(_ request: NetworkRequest<ResponseType>) async -> Int {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.httpBody = request.body
        
        do {
            let (_, response) = try await session.data(for: urlRequest)
            if let httpResponse = response as? HTTPURLResponse {
                return httpResponse.statusCode
            } else {
                return 0
            }
        } catch {
            return 0
        }
    }
    
    public func performBasicRequest<ResponseType: NetworkResponse>(_ request: NetworkRequest<ResponseType>) async throws -> (Data, URLResponse) {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.httpBody = request.body
        
        return try await session.data(for: urlRequest)
    }
}


