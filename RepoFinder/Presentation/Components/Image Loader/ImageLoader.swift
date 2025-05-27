//
//  ImageLoader.swift
//  RepoFinder
//
//  Created by Abdulrahman Alaa on 27/05/2025.
//

import SwiftUI

struct ImageLoader: View {
    
    let url: String
    var contentMode: SwiftUI.ContentMode = .fill
    var placeholder: ImageResource = .placeholder
    
    var body: some View {
        Rectangle()
            .opacity(0)
            .overlay {
                SDWebImageLoader(url: url, contentMode: contentMode) {
                    ZStack {
                        Color.gray
                            .overlay {
                                Image(placeholder)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundStyle(.gray)
                                    .padding(16)
                            }
                    }
                }
            }
            .clipped()
    }
}
