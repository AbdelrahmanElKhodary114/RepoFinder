//
//  LoadMoreIndicator.swift
//  RepoFinder
//
//  Created by Abdulrahman Alaa on 27/05/2025.
//


import SwiftUI

struct LoadMoreIndicator: View {
    
    var showProgress: Bool

    var body: some View {
        if showProgress {
            ProgressView()
                .padding(.vertical)
        }
    }
}
