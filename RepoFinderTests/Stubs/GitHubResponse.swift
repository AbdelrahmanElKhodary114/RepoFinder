//
//  GitHubResponse.swift
//  RepoFinder
//
//  Created by Abdulrahman Alaa on 27/05/2025.
//


@testable import RepoFinder

extension GitHubResponse {
    static let sample = GitHubResponse(
        totalCount: 20,
        items: [
            RepositoryResponse(
                id: 1,
                name: "Alaa",
                owner: Owner(id: 2, login: "Alaa", avatarURL: ""),
                description: "swift developer",
                stargazersCount: 20,
                language: "java"
            )
        ]
    )
}
