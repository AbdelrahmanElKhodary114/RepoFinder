//
//  Repositories+DI.swift
//  RepoFinder
//
//  Created by Abdulrahman Alaa on 27/05/2025.
//

import Factory

extension Container {
   
    var gitHubRepositorySearchRepo: Factory<GitHubRepositorySearchRepository> {
        self { GitHubRepositorySearchRepositoryImpl() }
    }
}


