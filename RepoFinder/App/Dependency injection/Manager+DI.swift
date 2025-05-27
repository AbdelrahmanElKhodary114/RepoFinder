//
//  Manager+DI.swift
//  RepoFinder
//
//  Created by Abdulrahman Alaa on 27/05/2025.
//

import Factory

extension Container {

    var networkService: Factory<HTTPClientProtocol> {
        self { NetworkService() }
    }
}
