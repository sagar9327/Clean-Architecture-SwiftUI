//
//  UserRepository.swift
//  Clean Architecture + SwiftUI
//
//  Created by Sagar Kalathil on 30/09/26.
//

protocol UserRepositoryProtocol {
    func getUsers() async throws -> [User]
}
