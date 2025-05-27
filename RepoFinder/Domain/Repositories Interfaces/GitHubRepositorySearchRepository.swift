//
//  GitHubRepositorySearchRepository.swift
//  RepoFinder
//
//  Created by Abdulrahman Alaa on 27/05/2025.
//

protocol GitHubRepositorySearchRepository {
    func searchRepositories(query: String, page: Int) async throws -> ChunkOfRepository
}
