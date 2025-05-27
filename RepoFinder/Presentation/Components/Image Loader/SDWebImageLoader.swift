//
//  SDWebImageLoader.swift
//  RepoFinder
//
//  Created by Abdulrahman Alaa on 27/05/2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct SDWebImageLoader<Placeholder: View>: View {
    
    let url: String
    var contentMode: ContentMode = .fill
    var placeholder: () -> Placeholder
    @State var showPlaceholder: Bool = false
    
    init(
        url: String,
        contentMode: ContentMode = .fill,
        @ViewBuilder placeholder: @escaping () -> Placeholder
    ) {
        self.url = url
        self.contentMode = contentMode
        self.placeholder = placeholder
        self.showPlaceholder = false
    }
    
    var body: some View {
        WebImage(url: URL(string: url)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: contentMode)
        } placeholder: {
            if showPlaceholder {
                placeholder()
            } else {
                Rectangle()
                    .foregroundColor(.gray)
                    .overlay {
                        ProgressView()
                    }
            }
        }
        .onFailure { _ in
            Task {
                await MainActor.run {
                    showPlaceholder = true
                }
            }
        }
        .indicator(.activity)
        .transition(.fade(duration: 0.5))
        
    }
}
