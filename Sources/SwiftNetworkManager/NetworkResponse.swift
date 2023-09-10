//
//  NetworkResponse.swift
//
//  Created by John Baker on 9/10/23.
//

import Foundation

/// Conform to Codable & Encodable
public protocol NetworkResponse: Codable, Encodable { }

/// Allow wrapping of responses in [] to be used as generic argument
extension Array: NetworkResponse where Element : NetworkResponse { }
