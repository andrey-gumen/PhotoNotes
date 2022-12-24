import PhotosUI
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    //@EnvironmentObject var dataModel: DataModel
    
    /// A dismiss action provided by the environment. This may be called to dismiss this view controller.
    @Environment(\.dismiss) var dismiss
    
    init() {
        
    }

    /// Creates the picker view controller that this object represents.
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> PHPickerViewController {
        var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        configuration.filter = .images
        configuration.preferredAssetRepresentationMode = .current

        let photoPickerViewController = PHPickerViewController(configuration: configuration)
        photoPickerViewController.delegate = context.coordinator
        return photoPickerViewController
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        // No updates are necessary.
    }
}

// MARK: UINavigationControllerDelegate, PHPickerViewControllerDelegate

final class Coordinator: NSObject, UINavigationControllerDelegate, PHPickerViewControllerDelegate {
    
    let parent: ImagePicker
    
    init(_ parent: ImagePicker) {
        self.parent = parent
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        parent.dismiss()

        guard
            let itemProvider = results.first?.itemProvider,
            itemProvider.hasItemConformingToTypeIdentifier(UTType.image.identifier)
        else { return }
        
        // Load a file representation of the picked item.
        // This creates a temporary file which is then copied to the app’s document directory for persistent storage.
        itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.image.identifier) { url, error in
            if let error = error {
                print("Error loading file representation: \(error.localizedDescription)")
            } else {
                guard let url = url else { return }
                
                // Add the new item to the data model.
//                    Task { @MainActor [dataModel = self.parent.dataModel] in
//                        withAnimation {
//                            let item = Item(url: savedUrl)
//                            dataModel.addItem(item)
//                        }
//                    }
            }
        }
    }

    
}