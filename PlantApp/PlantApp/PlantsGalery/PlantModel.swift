//
//  PlantModel.swift
//  PlantApp
//
//  Created by Михаил Прозорский on 22.07.2024.
//

import SwiftUI
import PhotosUI
import UIKit
import CoreTransferable
import SwiftData

@MainActor
class PlantModel: ObservableObject{
    init(imageState: ImageState, imageSelection: PhotosPickerItem? = nil) {
        self.imageState = imageState
        self.imageSelection = imageSelection
    }
    
    @Published private(set) var imageState: ImageState = .empty
    
    // Photo picked item
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            if let imageSelection {
                let progress = loadTransferable(from: imageSelection)
                imageState = .loading(progress)
            } else {
                imageState = .empty
            }
        }
    }
    
    struct PlantImage: Transferable {
        let image: Image
        
        static var transferRepresentation: some TransferRepresentation {
            DataRepresentation(importedContentType: .image) { data in
                guard let uiImage = UIImage(data: data) else {
                    throw TransferError.importFailed
                }
                
                UserDefaults.standard.set(data, forKey: "flowerImage")
                let image = Image(uiImage: uiImage)
                return PlantImage(image: image)
            }
        }
        
    }
    
    // Set image state for restore data from UserDefaults
    public func setImageStateSuccess(image: Image) {
        self.imageState = .success(image)
    }
    
    
    // MARK: - Private Methods
    
    // Loading state after go to success or failure
    private func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress {
        return imageSelection.loadTransferable(type: PlantImage.self) { result in
            DispatchQueue.main.async {
                guard imageSelection == self.imageSelection else {
                    print("Failed to get the selected item.")
                    return
                }
                switch result {
                case .success(let profileImage?):
                    self.imageState = .success(profileImage.image)
                case .success(nil):
                    self.imageState = .empty
                case .failure(let error):
                    self.imageState = .failure(error)
                }
            }
        }
    }
}

enum ImageState {
    case empty
    case loading(Progress)
    case success(Image)
    case failure(Error)
}

/// What if transfer image failed
enum TransferError: Error {
    case importFailed
}
