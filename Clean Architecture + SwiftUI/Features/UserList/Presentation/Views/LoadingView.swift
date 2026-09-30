//
//  LoadingView.swift
//  Clean Architecture + SwiftUI
//
//  Created by Sagar Kalathil on 30/09/26.
//

import SwiftUI
struct LoadingView: View {

    var body: some View {
        VStack(spacing: 12) {
            ProgressView()

            Text("Loading...")
                .foregroundStyle(.secondary)
        }
    }
}
