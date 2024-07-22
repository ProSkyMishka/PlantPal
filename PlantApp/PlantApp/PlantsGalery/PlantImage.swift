//
//  PlantImage.swift
//  PlantApp
//
//  Created by Михаил Прозорский on 22.07.2024.
//

import SwiftUI
import PhotosUI

struct PlantImage: View
{
    let imageState: ImageState
//    @Binding var plant: Plant
    var body: some View {
        switch imageState {
        case .success(let image):
            image.resizable()
        case .loading: // (let progress):
            ProgressView()
        case .empty:
            Image("defaultFlower")
                .resizable()
                .scaledToFit()
                .font(.system(size: 40))
                .foregroundColor(.white)
        case .failure: // (let error):
            Image("Warning")
                .font(.system(size: 40))
                .foregroundColor(Theme.backGround)
        }
    }
}
