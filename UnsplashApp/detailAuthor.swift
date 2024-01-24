//
//  detailAuthor.swift
//  UnsplashAppUITests
//
//  Created by Arthur LE-DEVEDEC on 1/24/24.
//

import Foundation
import SwiftUI

struct DetailAuthor: View {
    var user: User

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                AsyncImage(url: URL(string: user.profileImage.large)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .overlay(Circle().stroke(Color.blue, lineWidth: 3))
                        .frame(width: 120, height: 120)
                } placeholder: {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 120, height: 120)
                        .overlay(ProgressView())
                }
                .padding(.top, 20)
                
             
                VStack(alignment: .leading) {
                    Text(user.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color.blue)

                    Text("@\(user.username)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

               
                if let location = user.location, !location.isEmpty {
                    HStack {
                        Image(systemName: "location.fill")
                            .foregroundColor(.green)
                        Text(location)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 5)
                }
                Spacer()
                Spacer()
              
                if let bio = user.bio, !bio.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Biography")
                            .font(.headline)
                            .fontWeight(.medium)
                            .padding(.vertical, 10)

                        Text(bio)
                            .font(.body)
                            .lineSpacing(5)
                    }
                }

                Spacer()
            }
            .padding()
        }
        .navigationBarTitle("Biographie", displayMode: .inline)
    }
}
