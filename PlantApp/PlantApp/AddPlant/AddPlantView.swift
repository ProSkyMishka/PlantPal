//
//  AddPlantView.swift
//  PlantApp
//
//  Created by Lucy Rez on 08.07.2024.
//

import SwiftUI
import SwiftData

struct ResponseML: Codable {
    var classML: String
    var real_name: String
    var accuracy: String
}

struct ResultPlant: Codable {
    var id: String
    var description: String
    var humidity: String
    var temp: String
    var MLID: String
    var imageURL: String
    var seconds: Int
    var name: String
}

struct AddPlantView: View {
    @Environment(\.modelContext) var modelContext: ModelContext
    @Binding var path: NavigationPath
    @Binding var index: Int
    @State private var image: UIImage?
    @State public var resultsML: ResponseML = ResponseML(classML: "", real_name: "", accuracy: "")
    @State public var resultsServer:  ResultPlant = ResultPlant(id: "", description: "", humidity: "", temp: "", MLID: "", imageURL: "", seconds: 0, name: "")
    @State private var isInfoLoading = true
    @Binding var barHidden: Bool
    @State var isEditViewPresented = false
    @State var notRecognisable = false
    @State var clientText = "Is this really your plant?"
    
    
    var body: some View {
        NavigationStack {
            VStack {
                if (image == nil) {
                    CameraView(image: $image, barHidden: $barHidden)
                } else {
                    VStack {
                        
                        Text(clientText)
                            .foregroundColor(Theme.textBlue)
                            .font(.system(size: 28))
                            .padding(8)
                            .frame(width: UIScreen.main.bounds.width * 0.9)
                        
                        Image(uiImage: image!)
                            .resizable()
                            .frame(width: 250, height: 250)
                        
                        
                        if (isInfoLoading) {
                            ProgressView()
                        } else if !notRecognisable {
                            Text(resultsServer.name)
                                .font(.title)
                                .foregroundColor(Theme.textBrown)
                            
                            
                            Text(resultsServer.description)
                                .foregroundColor(Theme.description)
                                .font(.title3)
                            
                            HStack {
                                Button(action: {
                                    // Add to Swift data
                                    let plant = Plant(serverId: resultsServer.id,
                                                      desc: resultsServer.description,
                                                      humidity: resultsServer.humidity,
                                                      temp: resultsServer.temp,
                                                      MLID: resultsServer.MLID,
                                                      imageURL: resultsServer.imageURL,
                                                      seconds: resultsServer.seconds,
                                                      name: resultsServer.name)
                                    
                                    plant.image = image?.jpegData(compressionQuality: 1.0)
                                    modelContext.insert(plant)
                                    
                                    // Change to main screen
                                    index = 0
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
                                    EditCapturedPlantView(index: $index, isPresented: $isEditViewPresented, capturedPlant: resultsServer, image: $image)
                                }
                            }
                            .bold()
                            .font(.title2)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .cornerRadius(10)
                            .padding(.horizontal)
                        } else {
                            HStack {
                                Text("Repeat")
                                    .font(.system(size: 20))
                                    .foregroundColor(Theme.textBlue)
                                Image(systemName: "arrow.clockwise")
                                    .foregroundColor(Theme.textBlue)
                            }
                            .onTapGesture {
                                image = nil
                                notRecognisable = false
                                clientText = "Is this really your plant?"
                                barHidden.toggle()
                                isInfoLoading = true
                            }
                        }
                    }
                        .onAppear {
                            barHidden = false
                            recognizePlant()
                        }.background(Theme.backGround)
                }
                
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .background(Theme.backGround)
        }
        .onAppear{
            barHidden = true
        }
        

    }
    
    func postData(uiimage: UIImage) async {
        let boundary = UUID().uuidString
        
        let session = URLSession.shared
        var urlRequest = URLRequest(url: URL(string: "\(Constants.urlModelsServer)/predict/plant")!)
        print(urlRequest)
        
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
                if let json = jsonData as? [String: String] {
                    print(json)
                    resultsML = ResponseML(classML: json["classML"]!, real_name: json["real_name"]!, accuracy: json["accuracy"]!)
                    if Double(resultsML.accuracy) ?? -5 >= -3.5 {
                        Task {
                            await loadData()
                        }
                    } else {
                        clientText = "We cannot recognize your flower"
                        notRecognisable = true
                    }
                }
                
                DispatchQueue.main.async {
                    isInfoLoading = false
                }
            }
        }).resume()
    }
    
    func loadData() async {
        guard let url = URL(string: "\(Constants.urlServer)/plants/\(resultsML.classML)") else {
//        guard let url = URL(string: "http://\(Constants.ip):8080/plants/\(resultsML.classML)") else {
            print("Invalid URL")
            return
        }
        print(url)
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            print(data)
            let decodedResponse = try JSONDecoder().decode(ResultPlant.self, from: data)
            resultsServer = decodedResponse
        } catch {
            print(error)
        }
    }
    
    
    
    
    func recognizePlant() {
        Task {
            // Send image data to ML model
            // get MLID from the ML model and get the plant by MLID from server
            // Change isInfoLoading to false
            await postData(uiimage: image!)
        }
    }
    
}
