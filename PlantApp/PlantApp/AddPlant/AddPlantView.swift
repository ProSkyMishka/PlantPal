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
    @Binding var barHidden: Bool
    @State var isEditViewPresented = false
    @State var capturedPlant: PlantBaseModel = PlantBaseModel(name: "Rosa", description: "Description", url: "URL", temperatureRange: "temperature", humidity: "Yes", waterInterval: 12, nextWatering: Date(), replay: .everyDay)
    @State var colorTheme = ColorLight()
    
    
    var body: some View {
        VStack {
            if (image == nil) {
                CameraView(image: $image, barHidden: $barHidden)
            } else {
                VStack {
                    
                    Text("Это действительно ваше растение?")
//                    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                        .font(.system(size: 30))
                    
                    Image(uiImage: image!)
                        .resizable()
                        .frame(width: 250, height: 250)

            
                    Text("Описание")
//                    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                        .font(.title3)
                        .foregroundColor(.gray)
                    
                    if (isInfoLoading) {
                        ProgressView()
                    } else {
                        Text("Название")
                        
    //                    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

                            .font(.title)
                        // Show plant info
                        HStack {
                            Button(action: {
                                // coreData
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
                                isEditViewPresented = true
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.red)
                                    .padding()
                                    .cornerRadius(10)
                                    .padding(.horizontal)
                            }
                            .fullScreenCover(isPresented: $isEditViewPresented) {
                                EditCapturedPlantView(capturedPlant: $capturedPlant)
                            }
                        }
                        .bold()
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .cornerRadius(10)
                        .padding(.horizontal)
                    }
                }.background(Theme.backGround)
                .onAppear {
                    barHidden = false
                    recognizePlant()
                }
                
            }
            
        }
        .onAppear{
            barHidden = true
        }
    }
    
    func postData(uiimage: UIImage) async {
        let boundary = UUID().uuidString
        
        let session = URLSession.shared
        var urlRequest = URLRequest(url: URL(string: "http://10.29.91.25:8000/predict/plant")!)
        
        urlRequest.httpMethod = "POST"
        
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var data = Data()
        
        // Add the image data to the raw http request data
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append(uiimage.jpegData(compressionQuality: 1.0)!)
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
            if error == nil {
                let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
                if let json = jsonData as? [String: Any] {
                    print(json)
                }
                
                DispatchQueue.main.async {
                    isInfoLoading = false
                }
            }
        }).resume()
    }
    
    
    
    func recognizePlant() {
        Task {
            await postData(uiimage: image!)
        }
        
        // Send image data to ML model
        
        
        
        // get MLID from the ML model and get the plant by MLID from server
        
        // Change isInfoLoading to false
    }
    
}
