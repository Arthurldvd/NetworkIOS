//
//  TopicDetailsView.swift
//  UnsplashApp
//
//  Created by Arthur LE-DEVEDEC on 1/24/24.
//

import Foundation
import SwiftUI


struct TopicDetailsView: View {
    
    @StateObject var feedState = FeedState()
    @State var topic: UnslpashTopic
    
    func loadDataTopic() async {
        await feedState.fetchTopicFeed(topicId: topic.id)
    }
    
    
    var body: some View {
        Button(action: {
            Task {
                await loadDataTopic()
            }
        }, label: {
            Text("Load photos for \(topic.title)")
        })
        
            Grid(images: feedState.topicPhotoFeed)
            .navigationBarTitle(topic.title, displayMode: .large)
    }
}
