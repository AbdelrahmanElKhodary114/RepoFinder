//
//  GitHubRepositorySearchUseCase.swift
//  RepoFinder
//
//  Created by Abdulrahman Alaa on 27/05/2025.
//

import Factory

protocol GitHubRepositorySearchUseCase {
    func execute(searchText: String, page: Int) async throws -> ChunkOfRepository
}

struct GitHubRepositorySearchUseCaseImp: GitHubRepositorySearchUseCase {
    @Injected(\.gitHubRepositorySearchRepo) var gitHubRepositorySearchRepo

    func execute(searchText: String, page: Int) async throws -> ChunkOfRepository {
        try await gitHubRepositorySearchRepo.searchRepositories(query: searchText, page: page)
    }
}
