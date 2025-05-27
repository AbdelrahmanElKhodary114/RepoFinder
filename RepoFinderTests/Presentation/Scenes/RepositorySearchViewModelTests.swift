//
//  RepositorySearchViewModelTests.swift
//  RepoFinder
//
//  Created by Abdulrahman Alaa on 27/05/2025.
//

import XCTest
import Factory
@testable import RepoFinder

class RepositorySearchViewModelTests: XCTestCase {
    
    var sut: RepositorySearchViewModel!
    var useCase: MockGitHubRepositorySearchUseCase!
    
    override func setUp() {
        useCase = MockGitHubRepositorySearchUseCase()
        _ = Container.shared.gitHubRepositorySearchUseCase.register { self.useCase }
        sut = RepositorySearchViewModel()
    }
    
    func test_fetchRepositories_success() async {
        // Given
        let expectedChunk = ChunkOfRepository.sample
        useCase.result = .success(expectedChunk)
        sut.searchText = "Abdelrahman"
        
        // When
        sut.fetchRepositories()
        await Task.sleep(seconds: 0.1)
        
        // Then
        XCTAssertEqual(sut.repositoriesChunk.repositories.count, 1)
        XCTAssertEqual(sut.repositoriesChunk.repositories.first?.name, "Abdelrahman")
        XCTAssertFalse(sut.isShimmering)
        XCTAssertNil(sut.errorMessage)
    }

    func test_fetchRepositories_failure() async {
        // Given
        useCase.result = .failure(NSError(domain: "Test", code: 0))
        sut.searchText = "Abdelrahman"
        
        // When
        sut.fetchRepositories()
        await Task.sleep(seconds: 0.1)

        // Then
        XCTAssertTrue(sut.repositoriesChunk.repositories.isEmpty)
        XCTAssertNotNil(sut.errorMessage)
        XCTAssertFalse(sut.isShimmering)
    }
    
    func test_checkIfReachedEnd_shouldTriggerFetchMoreRepositories() async throws {
        // Given
        let initialChunk = ChunkOfRepository.sample
        useCase.result = .success(initialChunk)
        sut.searchText = "Abdelrahman"
        sut.fetchRepositories()
        await Task.sleep(seconds: 0.1)
        useCase.result = .success(ChunkOfRepository.sample2)
        // When
        if let lastRepo = ChunkOfRepository.sample.repositories.last {
            sut.checkIfReachedEnd(for: lastRepo)
            await Task.sleep(seconds: 0.1)
        } else {
            throw NSError(domain: "no last repo", code: 0)
        }

        // Then
        XCTAssertEqual(sut.repositoriesChunk.repositories.count, 2)
    }

    func test_fetchMoreRepositories_failure() async throws {
        // Given
        let initialChunk = ChunkOfRepository.sample
        useCase.result = .success(initialChunk)
        sut.searchText = "Abdelrahman"
        sut.fetchRepositories()
        await Task.sleep(seconds: 0.1)

        useCase.result = .failure(NSError(domain: "Test", code: 1))

        // When
        if let lastRepo = ChunkOfRepository.sample.repositories.last {
            sut.checkIfReachedEnd(for: lastRepo)
            await Task.sleep(seconds: 0.1)
        } else {
            throw NSError(domain: "no last repo", code: 0)
        }

        // Then
        XCTAssertEqual(sut.repositoriesChunk.repositories.count, 1)
        XCTAssertNotNil(sut.errorMessage)
    }
    
    func test_searchTextChange_triggersSearchAfterDebounce() {
        // Given
        let expectation = XCTestExpectation(description: "Debounced search")
        useCase.result = .success(.emptyData)

        // When
        sut.searchText = "Abdelrahman"

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            XCTAssertEqual(self.useCase.receivedSearchText, "Abdelrahman")
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 1)
    }

}


// MARK: - Mocks
extension RepositorySearchViewModelTests {
    
    class MockGitHubRepositorySearchUseCase: GitHubRepositorySearchUseCase {
      
        
        var result: Result<ChunkOfRepository, Error>?
        var receivedSearchText: String?
        var receivedPage: Int?
    
        func execute(searchText: String, page: Int) async throws -> ChunkOfRepository {
            receivedSearchText = searchText
            receivedPage = page
            if let result = result {
                switch result {
                case .success(let data):
                    return data
                case .failure(let error):
                    throw error
                }
            } else {
                fatalError("Should not throw error when no result is provided")
            }
        }
    }
}

extension Task where Success == Never, Failure == Never {
    static func sleep(seconds: Double = 0.1) async {
        let nanoseconds = UInt64(seconds * 1_000_000_000)
        try? await Task.sleep(nanoseconds: nanoseconds)
    }
}

