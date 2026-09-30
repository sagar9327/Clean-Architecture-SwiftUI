//
//  ErrorView.swift
//  Clean Architecture + SwiftUI
//
//  Created by Sagar Kalathil on 30/09/26.
//
import SwiftUI
struct ErrorView: View {

    let message: String
    let retryAction: () -> Void
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
            Text(message)
                .multilineTextAlignment(.center)
            Button("Retry") {
                retryAction()
            }
        }
        .padding()
    }
}
