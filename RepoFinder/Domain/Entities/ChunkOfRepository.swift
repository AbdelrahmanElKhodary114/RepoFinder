//
//  ChunkOfRepository.swift
//  RepoFinder
//
//  Created by Abdulrahman Alaa on 27/05/2025.
//

struct ChunkOfRepository: Equatable {
    var totalCount: Int
    var repositories: [Repository]
}

extension ChunkOfRepository {
    init(from model: GitHubResponse?) {
        self.totalCount = model?.totalCount ?? 0
        self.repositories = model?.items.compactMap{ Repository(from: $0) } ?? []
    }
}

extension ChunkOfRepository {
    static var shimmerData: ChunkOfRepository {
        ChunkOfRepository(totalCount: 0, repositories: .shimmerData)
    }
    
    static var emptyData: ChunkOfRepository {
        ChunkOfRepository(totalCount: 0, repositories: [])
    }
}
