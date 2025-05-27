//
//  RepoFinderApp.swift
//  RepoFinder
//
//  Created by Abdulrahman Alaa on 27/05/2025.
//

import SwiftUI

@main
struct RepoFinderApp: App {
    var body: some Scene {
        WindowGroup {
            RepositorySearchView(viewModel: RepositorySearchViewModel())
        }
    }
}
