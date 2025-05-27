//
//  SearchBarView.swift
//  RepoFinder
//
//  Created by Abdulrahman Alaa on 27/05/2025.
//

import SwiftUI

struct SearchBarView: View {
    
    let placeholder: String
    @Binding var searchText: String

    var body: some View {
        HStack(spacing: 12) {
            Image(.search)
                .frame(width: 20, height: 20)
                .foregroundColor(.secondary)

            TextField("", text: $searchText, prompt: Text(placeholder))
                .font(.callout)
                .foregroundColor(.primary)
                .disableAutocorrection(true)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.secondarySystemBackground))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.separator), lineWidth: 0.5)
                )
        )
    }
}
