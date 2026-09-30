
//
//  NetworkClientProtocol.swift
//  Clean Architecture + SwiftUI
//
//  Created by Sagar Kalathil on 30/09/26.
//
import Foundation

protocol NetworkClientProtocol {
    func request<T: Decodable>(url: String) async throws -> T
}

