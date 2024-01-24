//
//  FeedState.swift
//  UnsplashApp
//
//  Created by Arthur LE-DEVEDEC on 1/23/24.
//

import Foundation
import SwiftUI

class FeedState: ObservableObject {
    @Published var homeFeed: [UnsplashPhoto] = []
    @Published var topicFeed: [UnslpashTopic] = []
    @Published var topicPhotoFeed: [UnsplashPhoto] = []
    
    let api = UnsplashAPI()
    
    func fetchHomeFeed() async {
        let url = api.feedUrl(path: "/photos")!
        DispatchQueue.main.async {
            self.homeFeed = []
        }
        do {
            let request = URLRequest(url: url)
            let (data, _) = try await URLSession.shared.data(for: request)
            let deserializedData = try JSONDecoder().decode([UnsplashPhoto].self, from: data)
            print(deserializedData)
            await DispatchQueue.main.async {
                self.homeFeed = deserializedData
            }
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
    
    func fetchTopicFeed() async {
        let url = api.feedUrl(path: "/topics")!
        do {
            let request = URLRequest(url: url)
            let (data, _) = try await URLSession.shared.data(for: request)
            let deserializedData = try JSONDecoder().decode([UnslpashTopic].self, from: data)
            
            await DispatchQueue.main.async {
                self.topicFeed = deserializedData
            }
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
    
    func fetchImageOfTopicFeed(idTopic: String) async {
        let url = api.feedUrl(path: "/topics/\(idTopic)/photos")!

        DispatchQueue.main.async {
            self.topicPhotoFeed = []
        }
        
        do {
            let request = URLRequest(url: url)
            let (data, _) = try await URLSession.shared.data(for: request)
            let deserializedData = try JSONDecoder().decode([UnsplashPhoto].self, from: data)
            
            await DispatchQueue.main.async {
                self.topicPhotoFeed = deserializedData
                print(self.topicPhotoFeed.count)
            }
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
}
