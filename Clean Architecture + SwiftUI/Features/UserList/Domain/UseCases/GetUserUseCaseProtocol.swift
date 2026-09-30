//
//  GetUseCase.swift
//  Clean Architecture + SwiftUI
//
//  Created by Sagar Kalathil on 30/09/26.
//

protocol GetUserUseCaseProtocol {
    func execute() async throws -> [User]
}
