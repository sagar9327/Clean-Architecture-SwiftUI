//
//  NetworkError.swift
//  Clean Architecture + SwiftUI
//
//  Created by Sagar Kalathil on 30/09/26.
//
enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case httpError(statusCode: Int)
    case decodingError(Error)
}
