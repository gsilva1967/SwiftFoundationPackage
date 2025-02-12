//
//  ImagePicker.swift
//  MobileGoRecruit
//
//  Created by Michael Kacos on 12/7/23.
//

import PhotosUI
import SwiftUI


public  struct ImagePicker: UIViewControllerRepresentable {
     @Binding var image: UIImage?
    
    public init(image: Binding<UIImage?>? = nil) {
        self._image = image!
    }

    public func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    public func updateUIViewController(_: PHPickerViewController, context _: Context) {}

    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    
    public class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        
         public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
                 picker.dismiss(animated: true)
                
                guard let provider = results.first?.itemProvider else { return }
                
                 if provider.canLoadObject(ofClass: UIImage.self) {
                     
                    provider.loadObject(ofClass: UIImage.self) { image, _ in
                        if let image = image as? UIImage {
                            DispatchQueue.main.async {
                                self.parent.image = image 
                            }
                        }
                    }
                    
                }
            
        }
        
    }
    
    
}
