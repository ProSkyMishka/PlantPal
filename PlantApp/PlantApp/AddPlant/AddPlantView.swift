//
//  AddPlantView.swift
//  PlantApp
//
//  Created by Lucy Rez on 08.07.2024.
//

import SwiftUI

struct AddPlantView: View {
    
    @State private var image: UIImage?
    @State private var recognizedPlant: PlantBaseModel?
    @State private var isInfoLoading = true
    
    var body: some View {
        VStack {
            if (image == nil) {
                CameraView(image: $image)
            } else {
                VStack {
                    // View of taken picture
                    // Image
                    // Button to retake the image
                    
                    if (isInfoLoading) {
                        ProgressView()
                    } else {
                        // Show plant info
                    }
                }
                .onAppear {
                    recognizePlant()
                }
            }
        }
    }
    
    
    
    func recognizePlant() {
        
        // Send image data to ML model
        
        // get MLID from the ML model and get the plant by MLID from server
        
        // Change isInfoLoading to false
    }
    
}
