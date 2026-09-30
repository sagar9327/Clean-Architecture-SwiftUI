//___FILEHEADER___

import SwiftUI

@main
struct Clean_Architecture___SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            UserListView(viewModel: UserListViewModel(getUsersCase: GetUsersUseCase(repository: UserRepository(api: UserAPI(networkClient: NetworkClient())))))
        }
    }
}
