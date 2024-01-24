//
//  Grid.swift
//  UnsplashApp
//
//  Created by Arthur LE-DEVEDEC on 1/24/24.
//

import Foundation
import SwiftUI

struct Grid: View {
    var images: [UnsplashPhoto]
    let columnsItems: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

    var body: some View {
        NavigationStack() {
            ScrollView {
                LazyVGrid(columns: columnsItems, spacing: 8) {
                    if images.count == 0 {
                        ForEach(0..<12, id: \.self) { _ in
                            Rectangle()
                                .foregroundColor(.gray)
                                .aspectRatio(contentMode: .fill)
                                .cornerRadius(12)
                                .shadow(radius: 5)
                        }
                    } else {
                        ForEach(images, id: \.id) { image in
                            NavigationLink(destination: ImageDetailView(image: image)) {
                                AsyncImage(url: URL(string: image.urls.small)) { image in
                                    image
                                        .centerCropped()
                                        .aspectRatio(contentMode: .fill)
                                } placeholder: {
                                    ProgressView()
                                        .frame(height: 200)
                                }
                                .shadow(radius: 5)
                            }
                        }
                    }
                }
                .redacted(reason: images.isEmpty ? .placeholder : .init())
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(12)
        }
    }
}
