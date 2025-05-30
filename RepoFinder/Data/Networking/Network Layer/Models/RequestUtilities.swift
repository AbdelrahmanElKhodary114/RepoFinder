//
//  RequestUtilities.swift
//  RepoFinder
//
//  Created by Abdulrahman Alaa on 27/05/2025.
//


import Foundation

enum RequestEncoding {
    case url
    case json
}

enum RequestType {
    case normal
}

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}



