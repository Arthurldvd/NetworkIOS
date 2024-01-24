//
//  ImageDetailView.swift
//  UnsplashApp
//
//  Created by Arthur LE-DEVEDEC on 1/24/24.
//

import SwiftUI

struct ImageDetailView: View {
    let image: UnsplashPhoto

    var body: some View {
        VStack {
            
            AsyncImage(url: URL(string: image.urls.full)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                case .failure(let error):
                    Text("Failed to load image: \(error.localizedDescription)")
                case .empty:
                    ProgressView()
                @unknown default:
                    ProgressView()
                }
            }   
        }
        .navigationBarTitle("Une image de \(image.user.name)", displayMode: .inline)
    }
}
