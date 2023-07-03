//
//  ImagePicker.swift
//  NameTrainer
//
//  Created by Philipp Sanktjohanser on 16.01.23.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(photoPicker: self)
    }
    
    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let photoPicker: ImagePicker
        
        init(photoPicker: ImagePicker) {
            self.photoPicker = photoPicker
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.editedImage] as? UIImage {
//                guard let data = image.jpegData(compressionQuality: 0.1), let compressedImage = UIImage(data: data) else { return }
                photoPicker.selectedImage = image
            } else {
                // TODO: return error / show alert (user didn't pick an image or something went wrong)
            }
            picker.dismiss(animated: true)
        }
    }
}
