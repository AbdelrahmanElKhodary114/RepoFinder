//
//  RepositoryResponse.swift
//  RepoFinder
//
//  Created by Abdulrahman Alaa on 27/05/2025.
//

struct RepositoryResponse: Codable {
    let id: Int
    let name: String?
    let owner: Owner?
    let description: String?
    let stargazersCount: Int?
    let language: String?

    enum CodingKeys: String, CodingKey {
        case id, name, owner, description
        case stargazersCount = "stargazers_count"
        case language
    }
}

struct Owner: Codable {
    let id: Int?
    let login: String?
    let avatarURL: String?
    
    enum CodingKeys: String, CodingKey {
          case login, id
          case avatarURL = "avatar_url"
      }
}
