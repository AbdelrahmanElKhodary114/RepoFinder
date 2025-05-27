//
//  GitHubRepositorySearchUseCaseTest.swift
//  RepoFinder
//
//  Created by Abdulrahman Alaa on 27/05/2025.
//

import XCTest
import Factory
@testable import RepoFinder

class GitHubRepositorySearchUseCaseTest: XCTestCase {
    
    var sut: GitHubRepositorySearchUseCaseImp!
    var mockRepository: MockGitHubRepositorySearchRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockGitHubRepositorySearchRepository()
        let _ = Container.shared.gitHubRepositorySearchRepo.register { self.mockRepository }
        sut = GitHubRepositorySearchUseCaseImp()
    }
    
    override func tearDown() {
        sut = nil
        mockRepository = nil
        super.tearDown()
    }
    
    // MARK: - Success Cases
    func test_execute_callsRepositoryWithCorrectParameters() async {
        // Given
        mockRepository.result = .success(.sample)
        let testPage = 2
        let testSearchText = "abdo"
        
        // When
        do {
            _ = try await sut.execute(searchText: testSearchText, page: 2)
            XCTAssertEqual(mockRepository.receivedPage, testPage)
            XCTAssertEqual(mockRepository.receivedQuery, testSearchText)
        } catch {
            XCTFail("Should not throw error")
        }
    }
    
    func test_execute_returnsCorrectChunkOfRepository() async {
        // Given
        let expectedWeather = ChunkOfRepository.sample
        mockRepository.result = .success(expectedWeather)

        // When
        do {
            let result = try await sut.execute(searchText: "", page: 1)
            
            // Then
            XCTAssertEqual(result, expectedWeather)
        } catch {
            XCTFail("Should not throw error")
        }
    }
    
    // MARK: - Failure Cases
    
    func test_execute_throwsErrorWhenRepositoryFails() async {
        // Given
        let expectedError = NSError(domain: "TestError", code: 500)
        mockRepository.result = .failure(expectedError)
        
        // When
        do {
            _ = try await sut.execute(searchText: "", page: 1)
            XCTFail("Should throw error")
        } catch {
            // Then
            XCTAssertEqual(error as NSError, expectedError)
        }
    }
}

extension GitHubRepositorySearchUseCaseTest {
    
    class MockGitHubRepositorySearchRepository: GitHubRepositorySearchRepository {
     
        var result: Result<ChunkOfRepository, Error>?
        var receivedQuery: String?
        var receivedPage: Int?
        
        func searchRepositories(query: String, page: Int) async throws -> RepoFinder.ChunkOfRepository {
            receivedQuery = query
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
