//
//  ImagePicker.swift
//  ExpenseTracker
//
//  Created by Andrew Stannard on 12/11/2023.
//

import SwiftUI
import UIKit
import Photos
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @Binding var selectedImage: UIImage?
    @Binding var timeTaken: Date?
    
    @Environment(\.presentationMode) private var presentationMode
    
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
                print("image selected")

                
                // Check for photo library permissions
                let status = PHPhotoLibrary.authorizationStatus()
                if status == .notDetermined {
                    PHPhotoLibrary.requestAuthorization({status in
                        })
                }
                var asset: PHAsset?
                asset = info[UIImagePickerController.InfoKey.phAsset] as? PHAsset
                if asset == nil { print("asset nil")}
                
                if let asset = asset {
                    if let timeStamp = asset.creationDate {
                        print("Creation Date: \(timeStamp)")
                    }
                }
                
                   
//                if let asset = info[UIImagePickerController.InfoKey.phAsset] as? PHAsset {
//                    parent.timeTaken = asset.creationDate
//                    print("asset if condition")
//                    print(parent.timeTaken as Any)
//                }
                
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

