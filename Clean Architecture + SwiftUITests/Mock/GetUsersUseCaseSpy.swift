//
//  Untitled.swift
//  Clean Architecture + SwiftUI
//
//  Created by Sagar Kalathil on 30/09/26.
//
import XCTest
@testable import Clean_Architecture___SwiftUI

final class GetUsersUseCaseSpy: GetUserUseCaseProtocol {
    var users: [User] = []
    var error: Error?
    var executeCalled = false

    func execute() async throws -> [User] {

        executeCalled = true

        if let error {
            throw error
        }

        return users
    }
}
