//
//  Untitled.swift
//  Clean Architecture + SwiftUI
//
//  Created by Sagar Kalathil on 30/09/26.
//
import XCTest
@testable import Clean_Architecture___SwiftUI

final class UserAPISpy: UserAPIProtocol {

    var users: [UserDTO] = []
    var error: Error?

    func fetchUsers() async throws -> [UserDTO] {

        if let error {
            throw error
        }

        return users
    }
}
