//
//  UserAPI.swift
//  Clean Architecture + SwiftUI
//
//  Created by Sagar Kalathil on 30/09/26.
//

import Foundation

final class UserAPI: UserAPIProtocol {

    private let networkClient: NetworkClientProtocol

    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }

    func fetchUsers() async throws -> [UserDTO] {
        let endpoint = "https://jsonplaceholder.typicode.com/users"
        return try await networkClient.request(url: endpoint)
    }
}
