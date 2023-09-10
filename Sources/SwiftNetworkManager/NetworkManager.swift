//
//  NetworkManager.swift
//
//  Created by John Baker on 9/10/23.
//

import Foundation

public enum NetworkError: Error {
    case httpError(statusCode: Int)
    case decodingError(Error)
}

// MARK: - NetworkManager Class
public class NetworkManager {
    private let session: URLSession
    
    init() {
        let configuration = URLSessionConfiguration.default
        session = URLSession(configuration: configuration)
    }
    
    func performRequest<ResponseType: NetworkResponse>(_ request: NetworkRequest<ResponseType>) async throws -> ResponseType {
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
}


