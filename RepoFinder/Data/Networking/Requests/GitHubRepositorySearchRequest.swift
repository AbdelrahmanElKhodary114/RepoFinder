//
//  GitHubRepositorySearchRequest.swift
//  RepoFinder
//
//  Created by Abdulrahman Alaa on 27/05/2025.
//

struct GitHubRepositorySearchRequest: APIRequest {
    
    let path: String = "/search/repositories"
    var query: [String: Any]?
    
    init(query: String, page: Int) {
        self.query = [
            "q" : query,
            "page": page,
        ]
    }
}
