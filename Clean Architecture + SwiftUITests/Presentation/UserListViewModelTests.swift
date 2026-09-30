//
//  Untitled.swift
//  Clean Architecture + SwiftUI
//
//  Created by Sagar Kalathil on 30/09/26.
//
import XCTest
@testable import Clean_Architecture___SwiftUI

@MainActor
final class UserListViewModelTests: XCTestCase {

    func testLoadUsersSuccess() async {

        let useCase = GetUsersUseCaseSpy()

        useCase.users = [
            User(id: 1, name: "John"),
            User(id: 2, name: "Alice")
        ]

        let sut = UserListViewModel(
            getUsersCase: useCase
        )

        await sut.loadUsers()

        XCTAssertEqual(sut.arrUser.count, 2)
        XCTAssertEqual(sut.arrUser[0].name, "John")
        XCTAssertEqual(sut.arrUser[1].name, "Alice")
        XCTAssertFalse(sut.isLoading)
        XCTAssertNil(sut.errorMessage)
    }

    func testLoadUsersFailure() async {

        let useCase = GetUsersUseCaseSpy()

        useCase.error = TestError.someError

        let sut = UserListViewModel(
            getUsersCase: useCase
        )

        await sut.loadUsers()

        XCTAssertTrue(sut.arrUser.isEmpty)
        XCTAssertFalse(sut.isLoading)
        XCTAssertNotNil(sut.errorMessage)
    }

    func testLoadUsersCallsUseCase() async {

        let useCase = GetUsersUseCaseSpy()

        let sut = UserListViewModel(
            getUsersCase: useCase
        )

        await sut.loadUsers()

        XCTAssertTrue(useCase.executeCalled)
    }
}
