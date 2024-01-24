import SwiftUI
import Photos

struct ImageDetailView: View {
    let image: UnsplashPhoto
    
    @State private var isDownloading = false
    
    @State private var downloadAlert = false
    @State private var selectedImageFormatPicker: Urls.CodingKeys = .small
    @State private var showAuthorDetails = false
    
    var selectedImageFormat: String {
            switch selectedImageFormatPicker {
            case .raw: return image.urls.raw
            case .full: return image.urls.full
            case .regular: return image.urls.regular
            case .small: return image.urls.small
            case .thumb: return image.urls.thumb
            case .smallS3: return image.urls.smallS3
            }
        }
    
    
    
    var body: some View {
        
        VStack {
            Button(action: {
                showAuthorDetails = true
            }) {
                Text("Biographie de l'auteur")
                    .foregroundColor(.blue)
                    .font(.headline)
            }
            .sheet(isPresented: $showAuthorDetails) {
                DetailAuthor(user: image.user)
            }
            
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
        
        Button(action: {
            downloadImage(imageUrl: selectedImageFormat)
        }) {
            Text("Télécharger l'image")
        }
        .alert(isPresented: $downloadAlert) {
            Alert(
                title: Text("Téléchargement terminé"),
                message: Text("L'image a été téléchargée avec succès."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    private func downloadImage(imageUrl: String) {
        var imageServer: ImageSaver = ImageSaver()
        
        guard let url = URL(string: imageUrl) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                if let downloadedImage = UIImage(data: data) {
                    imageServer.saveImage(image: downloadedImage)
                    downloadAlert = true
                }
            }
        }.resume()
    }
}

class ImageSaver: NSObject {
    func saveImage(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            print("Image saved")
        }
    }
}
