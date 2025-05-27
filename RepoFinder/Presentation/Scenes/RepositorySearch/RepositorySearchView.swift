//
//  RepositorySearchView.swift
//  RepoFinder
//
//  Created by Abdulrahman Alaa on 27/05/2025.
//

import SwiftUI

struct RepositorySearchView: View {
    @StateObject var viewModel: RepositorySearchViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                SearchBarView(
                    placeholder: "Search repositories...",
                    searchText: $viewModel.searchText
                )
                .padding()

                if viewModel.repositoriesChunk.repositories.isEmpty {
                    emptyStateView
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    repoList
                }
                
            }
            .alert("Error",
                isPresented: .constant(viewModel.errorMessage != nil),
                actions: {Button("OK", role: .cancel) { viewModel.errorMessage = nil } },
                message: { Text(viewModel.errorMessage ?? "Unknown error")}
            )
            .background(Color(.systemGroupedBackground))
            .navigationTitle("GitHub Explorer")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private var repoList: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 16) {
                ForEach(viewModel.repositoriesChunk.repositories) { repo in
                    RepositoryCardView(repository: repo)
                        .onAppear {
                            viewModel.checkIfReachedEnd(for: repo)
                        }
                }

                LoadMoreIndicator(showProgress: viewModel.isFetchingMore)
            }
            .shimmeringRedact(shouldRedact: viewModel.isShimmering)
            .padding()
        }
    }

    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "magnifyingglass")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.secondary)

            Text(viewModel.searchText.isEmpty ? "Start searching for repositories" : "No repositories found"
            )
            .font(.headline)
            .foregroundColor(.primary)

            if !viewModel.searchText.isEmpty {
                Text("Try a different keyword")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .multilineTextAlignment(.center)
    }
}

