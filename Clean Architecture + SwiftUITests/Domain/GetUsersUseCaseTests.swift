//
//  Untitled.swift
//  Clean Architecture + SwiftUI
//
//  Created by Sagar Kalathil on 30/09/26.
//

import XCTest
@testable import Clean_Architecture___SwiftUI

final class GetUsersUseCaseTests: XCTestCase {

    func testExecuteReturnsUsersFromRepository() async throws {

        let repository = UserRepositorySpy()

        let expectedUsers = [
            User(id: 1, name: "John"),
            User(id: 2, name: "Alice")
        ]

        repository.users = expectedUsers

        let sut = GetUsersUseCase(repository: repository)

        let users = try await sut.execute()

        XCTAssertEqual(users.count, 2)
        XCTAssertEqual(users[0].name, "John")
        XCTAssertEqual(users[1].name, "Alice")
    }

    func testExecuteThrowsErrorWhenRepositoryFails() async {

        let repository = UserRepositorySpy()
        repository.error = TestError.someError

        let sut = GetUsersUseCase(repository: repository)

        do {
            _ = try await sut.execute()
            XCTFail("Expected execute() to throw an error")
        } catch {
            XCTAssertEqual(error as? TestError, .someError)
        }
    }
}
