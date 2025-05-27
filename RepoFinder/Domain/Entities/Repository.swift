//
//  Repository.swift
//  RepoFinder
//
//  Created by Abdulrahman Alaa on 27/05/2025.
//

struct Repository: Identifiable, Equatable {
    let id: Int
    let name: String
    let description: String
    let language: String
    let starsCount: String
    let ownerName: String
    let ownerAvatarURL: String
}

extension Repository {
    init?(from model: RepositoryResponse?) {
        guard let model else { return nil }
        self.id = model.id
        self.name = model.name ?? "Unknown"
        self.description = model.description ?? "No description"
        self.language = model.language ?? "Unknown"
        self.starsCount = "\(model.stargazersCount ?? 0)"
        self.ownerName = model.owner?.login ?? ""
        self.ownerAvatarURL = model.owner?.avatarURL ?? ""
    }
}

extension Array where Element == Repository {

    private static var empty: Repository {
        Repository(
            id: Int.random(in: 0...10000),
            name: "    ",
            description: "      ",
            language: "   ",
            starsCount: "    ",
            ownerName: "     ",
            ownerAvatarURL: ""
        )
    }
    
    static let shimmerData: [Repository] = [empty, empty, empty, empty, empty, empty, empty]
}


