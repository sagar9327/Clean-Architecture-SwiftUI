//
//  Untitled.swift
//  Clean Architecture + SwiftUI
//
//  Created by Sagar Kalathil on 30/09/26.
//
import XCTest
@testable import Clean_Architecture___SwiftUI
final class UserRepositorySpy: UserRepositoryProtocol {

    var users: [User] = []
    var error: Error?

    func getUsers() async throws -> [User] {

        if let error {
            throw error
        }

        return users
    }
}

enum TestError: Error, Equatable {
    case someError
}
