//
//  RepositorySearchViewModel.swift
//  RepoFinder
//
//  Created by Abdulrahman Alaa on 27/05/2025.
//

import Foundation
import Factory
import Combine

class RepositorySearchViewModel: ObservableObject {
    
    @Injected(\.gitHubRepositorySearchUseCase) private var searchRepositoriesUseCase

    @Published var repositoriesChunk: ChunkOfRepository = .emptyData
    @Published var searchText: String = ""
    @Published var isShimmering: Bool = true
    @Published var isFetchingMore: Bool = false
    @Published var errorMessage: String? = nil

    private var currentPage: Int = 1
    private var cancellables = Set<AnyCancellable>()

    init() {
        observeSearchText()
    }

    private func observeSearchText() {
        $searchText
            .dropFirst()
            .map { $0.trimmed }
            .filter { [weak self] str in
                str.isEmpty == false || self?.searchText.trimmed.isEmpty == false
            }
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { [weak self] _ in
                guard let self else { return }
                if searchText.isEmpty {
                    repositoriesChunk = .emptyData
                } else {
                    fetchRepositories()
                }
            }
            .store(in: &cancellables)
    }

    func fetchRepositories() {
        Task { @MainActor in
            
            currentPage = 1
            repositoriesChunk = .shimmerData
            isShimmering = true
            
            defer { isShimmering = false }
            do {
                let result = try await searchRepositoriesUseCase.execute(
                    searchText: searchText,
                    page: currentPage
                )
                
                repositoriesChunk = result
            } catch {
                repositoriesChunk = .emptyData
                errorMessage = error.localizedDescription
            }
        }
    }

    func checkIfReachedEnd(for repo: Repository) {
        guard !isShimmering, !isFetchingMore else { return }

        if repo.id == repositoriesChunk.repositories.last?.id {
            fetchMoreRepositories()
        }
    }

    private func fetchMoreRepositories() {
        guard repositoriesChunk.repositories.count < repositoriesChunk.totalCount else { return }

        Task { @MainActor in
            isFetchingMore = true

            defer { isFetchingMore = false }
            do {
                let newPage = currentPage + 1
                let result = try await searchRepositoriesUseCase.execute(
                    searchText: searchText,
                    page: newPage
                )
                currentPage = newPage
                repositoriesChunk.totalCount = result.totalCount
                repositoriesChunk.repositories.append(contentsOf: result.repositories)
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}

