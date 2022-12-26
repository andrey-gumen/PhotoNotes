import Combine
import SwiftUI


struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var isPresented
    
    let selectedImageUrlsubject = PassthroughSubject<URL?, Never>()
    var sourceType: UIImagePickerController.SourceType
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let isSourceTypeAvailable = UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)
        //print("is camera available: \(isSourceTypeAvailable)")
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = self.sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

// MARK: UINavigationControllerDelegate, PHPickerViewControllerDelegate

final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let context: ImagePicker
    
    init(_ context: ImagePicker) {
        self.context = context
    }
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        // dismiss view at the end anyway
        defer {
            context.isPresented.wrappedValue.dismiss()
        }
        
        let selectedImageUrl = info[.imageURL] as? URL
        context.selectedImageUrlsubject.send(selectedImageUrl)
    }

}
