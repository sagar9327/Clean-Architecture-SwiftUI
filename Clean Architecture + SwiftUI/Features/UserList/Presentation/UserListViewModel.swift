//
//  UserListViewModle.swift
//  Clean Architecture + SwiftUI
//
//  Created by Sagar Kalathil on 30/09/26.
//
import Foundation

@MainActor
final class UserListViewModel: ObservableObject {
    
    private var getUsersCase: GetUserUseCaseProtocol
    
    @Published var arrUser = [User]()
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    init(getUsersCase: GetUserUseCaseProtocol) {
        self.getUsersCase = getUsersCase
    }
    
    func loadUsers() async {
        isLoading = true
        errorMessage = nil
        do {
            arrUser = try await getUsersCase.execute()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
