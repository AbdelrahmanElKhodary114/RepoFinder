//
//  UseCases+DI.swift
//  RepoFinder
//
//  Created by Abdulrahman Alaa on 27/05/2025.
//

import Factory

extension Container {
   
    var gitHubRepositorySearchUseCase: Factory<GitHubRepositorySearchUseCase> {
        self { GitHubRepositorySearchUseCaseImp() }
    }
}



