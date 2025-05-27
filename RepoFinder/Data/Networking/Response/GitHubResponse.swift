//
//  GitHubResponse.swift
//  RepoFinder
//
//  Created by Abdulrahman Alaa on 27/05/2025.
//

struct GitHubResponse: Codable {
    let totalCount: Int
    let items: [RepositoryResponse]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}
