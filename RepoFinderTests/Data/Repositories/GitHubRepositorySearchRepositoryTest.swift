//
//  GitHubRepositorySearchRepositoryTest.swift
//  RepoFinder
//
//  Created by Abdulrahman Alaa on 27/05/2025.
//

import Factory
import XCTest
@testable import RepoFinder

class GitHubRepositorySearchRepositoryTest: XCTestCase {
    var sut: GitHubRepositorySearchRepositoryImpl!
    var mockNetworkService: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        _ = Container.shared.networkService.register { self.mockNetworkService }
        sut = GitHubRepositorySearchRepositoryImpl()
    }
    
    override func tearDown() {
        sut = nil
        mockNetworkService = nil
        super.tearDown()
    }
    
    
    // MARK: - Success Cases
    
    func test_searchRepositories_callsNetworkServiceWithCorrectRequest() async {
        // Given
        let expectedResponse = GitHubResponse.sample
        mockNetworkService.fetchResult = .success(expectedResponse)
        let query = "abdo"
        let page = 1
        
        // When
        do {
            _ = try await sut.searchRepositories(query: query, page: page)
            
            // Then
            XCTAssertTrue(mockNetworkService.fetchCalled)
            guard let request = mockNetworkService.lastRequest as? GitHubRepositorySearchRequest else {
                XCTFail("Wrong request type")
                return
            }
            XCTAssertNotNil(request.query?["q"] as? String)
            XCTAssertNotNil(request.query?["page"] as? Int)
            
            let qInRequestQuery =  request.query?["q"] as! String
            let pageInRequestQuery = request.query?["page"] as! Int
            
            XCTAssertEqual(qInRequestQuery, query)
            XCTAssertEqual(pageInRequestQuery, page)
        } catch {
            XCTFail("Should not throw error: \(error)")
        }
    }
    
    func test_searchRepositories_returnsCorrectChunkOfRepositoryModel() async {
        // Given
        let expectedResponse = GitHubResponse.sample
        mockNetworkService.fetchResult = .success(expectedResponse)
        let expectedEntity = ChunkOfRepository(from: expectedResponse)
        
        // When
        do {
            let result = try await sut.searchRepositories(query: "", page: 1)
            
            // Then
            XCTAssertEqual(result.totalCount, expectedEntity.totalCount)
            XCTAssertEqual(result.repositories, expectedEntity.repositories)
        } catch {
            XCTFail("Should not throw error: \(error)")
        }
    }
    
    // MARK: - Failure Cases
    
    func test_searchRepositories_throwsErrorWhenNetworkFails() async {
        // Given
        let expectedError = NSError(domain: "TestError", code: 500)
        mockNetworkService.fetchResult = .failure(expectedError)
        
        // When
        do {
            _ = try await sut.searchRepositories(query: "", page: 1)
            XCTFail("Should throw error")
        } catch {
            // Then
            XCTAssertEqual(error as NSError, expectedError)
        }
    }
    
}



//MARK: Mocks

extension GitHubRepositorySearchRepositoryTest {

    class MockNetworkService: HTTPClientProtocol {
        var requestProgress: ((Float) -> Void)?
        
        // Properties to track calls and control behavior
        var fetchCalled = false
        var lastRequest: APIRequest?
        var fetchResult: Result<Any, Error>?
        
        func fetch<T: Codable>(request: APIRequest) async throws -> T {
            fetchCalled = true
            lastRequest = request
            
            if let result = fetchResult {
                switch result {
                case .success(let value):
                    if let typedValue = value as? T {
                        return typedValue
                    } else {
                        throw MockError.typeMismatch
                    }
                case .failure(let error):
                    throw error
                }
            } else {
                throw MockError.resultNotSet
            }
        }
        
        enum MockError: Error {
            case resultNotSet
            case typeMismatch
        }
    }
}
