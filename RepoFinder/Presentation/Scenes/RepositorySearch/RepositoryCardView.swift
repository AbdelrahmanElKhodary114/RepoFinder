//
//  RepositoryCardView.swift
//  RepoFinder
//
//  Created by Abdulrahman Alaa on 27/05/2025.
//

import SwiftUI

struct RepositoryCardView: View {
    let repository: Repository

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 12) {
                ImageLoader(url: repository.ownerAvatarURL)
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())
                    .shadow(radius: 2)

                VStack(alignment: .leading, spacing: 2) {
                    Text(repository.name)
                        .font(.headline)
                        .foregroundColor(.primary)

                    Text("by \(repository.ownerName)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Spacer()
            }

            Text(repository.description)
                .font(.subheadline)
                .foregroundColor(.primary)
                .lineLimit(3)

            HStack(spacing: 16) {
                Label {
                    Text(repository.language)
                } icon: {
                    Image(systemName: "chevron.left.forwardslash.chevron.right")
                }
                .font(.caption)
                .foregroundColor(.blue)

                Label {
                    Text(repository.starsCount)
                } icon: {
                    Image(systemName: "star.fill")
                }
                .font(.caption)
                .foregroundColor(Color(red: 0.72, green: 0.6, blue: 0.08))

                Spacer()
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(.secondarySystemBackground))
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 3)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.separator), lineWidth: 0.5)
        )
    }
}
