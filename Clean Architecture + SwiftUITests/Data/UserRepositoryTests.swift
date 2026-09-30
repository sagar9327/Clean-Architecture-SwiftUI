//
//  Untitled.swift
//  Clean Architecture + SwiftUI
//
//  Created by Sagar Kalathil on 30/09/26.
//
import XCTest
@testable import Clean_Architecture___SwiftUI

final class UserRepositoryTests: XCTestCase {

    func testGetUsersMapsDTOToDomainModel() async throws {

        let api = UserAPISpy()

        api.users = [
            UserDTO(id: 1, name: "John"),
            UserDTO(id: 2, name: "Alice")
        ]

        let sut = UserRepository(api: api)

        let users = try await sut.getUsers()

        XCTAssertEqual(users.count, 2)
        XCTAssertEqual(users[0].id, 1)
        XCTAssertEqual(users[0].name, "John")
        XCTAssertEqual(users[1].id, 2)
        XCTAssertEqual(users[1].name, "Alice")
    }

    func testGetUsersThrowsErrorWhenAPIFails() async {

        let api = UserAPISpy()
        api.error = TestError.someError

        let sut = UserRepository(api: api)

        do {
            _ = try await sut.getUsers()
            XCTFail("Expected getUsers() to throw an error")
        } catch {
            XCTAssertEqual(error as? TestError, .someError)
        }
    }
}
