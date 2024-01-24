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
        
        do {
            let request = URLRequest(url: url)
            let (data, _) = try await URLSession.shared.data(for: request)
            let deserializedData = try JSONDecoder().decode([UnsplashPhoto].self, from: data)
            print(deserializedData)
            self.homeFeed = deserializedData
        } catch {
            print("\(error)")
        }
    }
    
    func fetchTopic() async {
        let url = api.feedUrl(path: "/topics")!
        do {
            let request = URLRequest(url: url)
            let (data, _) = try await URLSession.shared.data(for: request)
            let deserializedData = try JSONDecoder().decode([UnslpashTopic].self, from: data)
            self.topicFeed = deserializedData
        } catch {
            print("\(error)")
        }
    }
    
    func fetchTopicFeed(topicId: String) async {
        let url = api.feedUrl(path: "/topics/\(topicId)/photos")!
  
        do {
            let request = URLRequest(url: url)
            let (data, _) = try await URLSession.shared.data(for: request)
            let deserializedData = try JSONDecoder().decode([UnsplashPhoto].self, from: data)
            self.topicPhotoFeed = deserializedData
        } catch {
            print("\(error)")
        }
    }
}
