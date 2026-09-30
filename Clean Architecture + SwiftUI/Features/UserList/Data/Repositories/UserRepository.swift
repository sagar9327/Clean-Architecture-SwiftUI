//
//  UserRepositoryImpl.swift
//  Clean Architecture + SwiftUI
//
//  Created by Sagar Kalathil on 30/09/26.
//

final class UserRepository: UserRepositoryProtocol {

    private let api: UserAPIProtocol

    init(api: UserAPIProtocol) {
        self.api = api
    }

    func getUsers() async throws -> [User] {
        let response = try await api.fetchUsers()

        return response.map {
            User(
                id: $0.id,
                name: $0.name
            )
        }
    }
}
