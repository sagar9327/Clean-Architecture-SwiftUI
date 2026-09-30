//
//  NetworkClient.swift
//  Clean Architecture + SwiftUI
//
//  Created by Sagar Kalathil on 30/09/26.
//

import Foundation

final class NetworkClient: NetworkClientProtocol {

    private let session: URLSession
    private let decoder: JSONDecoder

    init(
        session: URLSession = .shared,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.session = session
        self.decoder = decoder
    }

    func request<T: Decodable>(
        url: String
    ) async throws -> T {
        guard let url = URL(string: url) else {
            throw NetworkError.invalidURL
        }
        let (data, response) = try await session.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.httpError(
                statusCode: httpResponse.statusCode
            )
        }
        do {
            return try decoder.decode(
                T.self,
                from: data
            )
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
}
