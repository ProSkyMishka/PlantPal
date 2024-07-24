//
//  ChangableAvatarView.swift
//  PlantApp
//
//  Created by Михаил Прозорский on 22.07.2024.
//

import SwiftUI
import PhotosUI

struct ChangableAvatarView: View
{
    @ObservedObject var viewModel: PlantModel
    @Bindable var plant: Plant
    
    var body: some View {
        PlantImage(imageState: viewModel.imageState)
            .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.width - 40)
//            .cornerRadius(15)
            .overlay(alignment: .center) {
                PhotosPicker(selection: $viewModel.imageSelection, matching: .images, photoLibrary: .shared()) {
                    Circle()
                        .opacity(0)
                }
                .buttonStyle(.borderless)
                .onDisappear {
                    let data: Data? = UserDefaults.standard.data(forKey: "flowerImage") as Data?
                    
                    if let data = data {
                        plant.image = data
                        UserDefaults.standard.removeObject(forKey: "flowerImage")
                    }
                }
            }
    }
}

