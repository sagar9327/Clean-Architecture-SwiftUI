//
//  GetUseCase.swift
//  Clean Architecture + SwiftUI
//
//  Created by Sagar Kalathil on 30/09/26.
//
final class GetUsersUseCase: GetUserUseCaseProtocol {

    private let repository: UserRepositoryProtocol

    init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async throws -> [User] {
        try await repository.getUsers()
    }
}
