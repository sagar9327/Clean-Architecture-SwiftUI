//
//  UserAPI.swift
//  Clean Architecture + SwiftUI
//
//  Created by Sagar Kalathil on 30/09/26.
//
import Foundation

protocol UserAPIProtocol {
    func fetchUsers() async throws -> [UserDTO]
}
