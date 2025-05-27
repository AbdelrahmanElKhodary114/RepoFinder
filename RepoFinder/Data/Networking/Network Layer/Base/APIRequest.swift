//
//  APIRequest.swift
//  RepoFinder
//
//  Created by Abdulrahman Alaa on 27/05/2025.
//

import Foundation

protocol APIRequest {
    var path: String { get }
    var baseURL: String { get }
    var method: RequestMethod { get }
    var requestType: RequestType { get }
    var encoding: RequestEncoding { get }
    var headers: [String: String]? { get }
    var query: [String: Any]? { get }
    var body: [String: Any]? { get }
}

extension APIRequest {
    
    var baseURL: String { "https://api.github.com" }
    var method: RequestMethod { .get }
    var requestType: RequestType { .normal }
    var encoding: RequestEncoding { .url }
    var body: [String: Any]? { nil }

    var headers: [String: String]? {
        return [:]
    }
}
