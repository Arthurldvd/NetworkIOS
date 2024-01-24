import SwiftUI

struct ContentView: View {
    @StateObject var feedState = FeedState()
    let rowTopics: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    func loadData() async {
        await feedState.fetchHomeFeed()
        await feedState.fetchTopic()
    }
    
    var body: some View {
        NavigationStack() {
            Section() {
                VStack {
                    HStack(spacing: 8) {
                        ForEach(feedState.topicFeed.prefix(3), id: \.id) { topic in
                            NavigationLink(destination: TopicDetailsView(topic: topic)) {
                                VStack() {
                                    AsyncImage(url: URL(string: topic.coverPhoto.urls.small)) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(height: 60)
                                    .cornerRadius(12)
                                    .shadow(radius: 5)
                                    
                                    Text(topic.title)
                                }
                            }
                        }
                    }
                }
            }
            
            .frame(height: 100)
            
            Section() {
                VStack {
                    Button(action: {
                        Task {
                            await loadData()
                        }
                    }, label: {
                        Text("Load Data")
                    })
                }
                Grid(images: feedState.homeFeed)
            }
            .navigationBarTitle("Feed", displayMode: .large)
        }
    }
}

extension Image {
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
                .resizable()
                .scaledToFill()
                .frame(width: geo.size.width, height: geo.size.height)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .clipped()
        }
    }
}
