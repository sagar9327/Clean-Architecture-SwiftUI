//
//  UserListView.swift
//  Clean Architecture + SwiftUI
//
//  Created by Sagar Kalathil on 30/09/26.
//

import SwiftUI

struct UserListView: View {

    @StateObject private var viewModel: UserListViewModel

    init(viewModel: UserListViewModel) {
        _viewModel = StateObject(
            wrappedValue: viewModel
        )
    }

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Users")
                .task {
                    await viewModel.loadUsers()
                }
        }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading {
            LoadingView()
        } else if let errorMessage = viewModel.errorMessage {
            ErrorView(
                message: errorMessage,
                retryAction: {
                    Task {
                        await viewModel.loadUsers()
                    }
                }
            )
        } else {
            userList
        }
    }

    private var userList: some View {
        List(viewModel.arrUser, id: \.id) { user in
            VStack(
                alignment: .leading,
                spacing: 4
            ) {
                Text(user.name)
                    .font(.headline)
                Text("ID: \(user.id)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(.vertical, 4)
        }
    }
}
