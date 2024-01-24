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
        Text("Détails de l'auteur \(user.name)")
        
    }
}
