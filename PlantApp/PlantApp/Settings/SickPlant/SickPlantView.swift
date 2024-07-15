//
//  SickPlantView.swift
//  PlantApp
//
//  Created by Lucy Rez on 15.07.2024.
//

import SwiftUI
import SwiftData

struct SickPlantView: View {
    @State private var image: UIImage?
    @Binding var barHidden: Bool
    @Environment(\.dismiss) private var dismiss
    @Binding var index: Int
    var body: some View {
            VStack {
                if (image == nil) {
                    CameraView(image: $image, barHidden: $barHidden)
                } else {
                    ScrollView{
                        VStack {
                            
                            Text("Definition of the disease")
                                .foregroundColor(Theme.textBlue)
                                .font(.system(size: 28))
                                .padding(8)
                            
                            Image(uiImage: image!)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 250)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                                .padding()
                            Text("Disease")
                                .font(.largeTitle)
                            Text("Description")
                                .font(.title)
                                .padding(.bottom)
                            Text("Add this disease to the plant profile?")
                            HStack{
                                Button(action: {
                                    dismiss()
                                    index = 0
                                    barHidden = false
                                }) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(.green)
                                        .padding()
                                        .cornerRadius(10)
                                        .padding(.horizontal)
                                }
                                Button(action: {
                                    dismiss()
                                    index = 0
                                    barHidden = false
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(.red)
                                        .padding()
                                        .cornerRadius(10)
                                        .padding(.horizontal)

                                }
                                
                            };Spacer()
                                
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden()

            .toolbar(content: {
                ToolbarItem(placement: .automatic) {
                    Text("App Info")
                        .font(.title2)
                        .foregroundColor(Theme.textGreen)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Theme.icon)
                        
                        Text("Back")
                            .font(.system(size: 20))
                            .foregroundColor(Theme.icon)
                    }
                    .onTapGesture {
                        dismiss()
                        barHidden = false
                    }
                }
            })
    }
}
