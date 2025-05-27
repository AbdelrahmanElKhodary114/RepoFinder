//
//  ChunkOfRepository.swift
//  RepoFinder
//
//  Created by Abdulrahman Alaa on 27/05/2025.
//

@testable import RepoFinder

extension ChunkOfRepository {
    static let sample = ChunkOfRepository(
        totalCount: 10,
        repositories: [
            Repository(
                id: 1,
                name: "Abdelrahman",
                description: "iOS Developer",
                language: "swift",
                starsCount: "100",
                ownerName: "AbdelrahmanElkhodary",
                ownerAvatarURL: ""
            )
        ]
    )
    
    static let sample2 = ChunkOfRepository(
        totalCount: 10,
        repositories: [
            Repository(
                id: 2,
                name: "Abdelrahman",
                description: "iOS Developer",
                language: "swift",
                starsCount: "100",
                ownerName: "AbdelrahmanElkhodary",
                ownerAvatarURL: ""
            )
        ]
    )
       
}

