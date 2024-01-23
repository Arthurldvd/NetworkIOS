import SwiftUI

struct ContentView: View {
    @State var imageList: [UnsplashModel] = []

    // Ajout de la définition des colonnes pour le LazyVGrid
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    func loadData() async {
        let url = URL(string: "https://api.unsplash.com/photos?client_id=\(ConfigurationManager.instance.plistDictionnary.clientId)")!

        do {
            let request = URLRequest(url: url)
            let (data, _) = try await URLSession.shared.data(for: request)
            let deserializedData = try JSONDecoder().decode([UnsplashModel].self, from: data)
            imageList = deserializedData
        } catch {
            print("Error: \(error)")
        }
    }

    var body: some View {
        VStack {
            Button(action: {
                Task {
                    await loadData()
                }
            }, label: {
                Text("Load Data")
            })
            ScrollView {
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(imageList, id: \.id) { item in
                        AsyncImage(url: URL(string: item.urls.small)) { image in
                            image
                                .centerCropped()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            ProgressView()
                        }
                        .cornerRadius(12)
                        .shadow(radius: 5)
                    }
                }
                .padding(.horizontal)
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
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
            .clipped()
        }
    }
}
