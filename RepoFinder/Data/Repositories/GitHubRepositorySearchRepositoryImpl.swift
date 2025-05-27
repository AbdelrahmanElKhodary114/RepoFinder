//
//  GitHubRepositorySearchRepositoryImpl.swift
//  RepoFinder
//
//  Created by Abdulrahman Alaa on 27/05/2025.
//

import Factory

struct GitHubRepositorySearchRepositoryImpl: GitHubRepositorySearchRepository {
    
    @Injected(\.networkService) var networkService
    
    func searchRepositories(query: String, page: Int) async throws -> ChunkOfRepository {
        let request = GitHubRepositorySearchRequest(query: query, page: page)
        let response: GitHubResponse? = try await networkService.fetch(request: request)
        return ChunkOfRepository(from: response)
    }
}
