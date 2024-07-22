//
//  SickPlantView.swift
//  PlantApp
//
//  Created by Lucy Rez on 15.07.2024.
//

//
//  AddPlantView.swift
//  PlantApp
//
//  Created by Lucy Rez on 08.07.2024.
//

import SwiftUI
import SwiftData

struct ResponseDisease: Identifiable {
    let id: Int
    let name: String
    let acc: Int
}

struct SickPlantView: View {
    @State private var image: UIImage?
    @State public var resultsML: [ResponseDisease] = []
    @State private var isInfoLoading = true
    @Binding var barHidden: Bool
    @Environment(\.dismiss) private var dismiss
    @State var countDiseases: Int = 6
    
    let disease_names = ["leaf spot",
                         "calcium deficiency",
                         "leaf scorch",
                         "leaf blight",
                         "curly yellow virus",
                         "yellow vein mosaic"]
    
    var body: some View {
        //        NavigationStack {
        VStack {
            if (image == nil) {
                CameraView(image: $image, barHidden: $barHidden)
            } else {
                VStack {
                    Text("AI thinks it is:")
                        .foregroundColor(Theme.textBlue)
                        .font(.system(size: 28))
                        .padding(8)
                    
                    Image(uiImage: image!)
                        .resizable()
                        .frame(width: 250, height: 250)
                    
                    if (isInfoLoading) {
                        ProgressView()
                    } else {
                        Text("Diagnose")
                            .foregroundColor(Theme.textBlue)
                            .font(.system(size: 28))
                            .padding(8)
                        ScrollView {
                            VStack {
                                if countDiseases != 0 {
                                    ForEach(resultsML) { result in
                                        HStack {
                                            if result.acc != 0 {
                                                Text(result.name)
                                                    .font(.title)
                                                    .foregroundColor(Theme.textBrown)
                                                Spacer()
                                                Text(String(result.acc) + " %")
                                                    .font(.title)
                                                    .foregroundColor(Theme.textBrown)
                                            }
                                        }
                                    }
                                    .background(Theme.backGround)
                                    .padding([.horizontal])
                                } else {
                                    Text("We cannot recognize any diseases")
                                        .font(.title)
                                        .foregroundColor(Theme.textBrown)
                                }
                            }
                        }
                        .frame(height: UIScreen.main.bounds.height * 0.35)
                    }
                }
                .onAppear {
                    recognizeSick()
                }
                .background(Theme.backGround)
                .padding([.vertical], 40)
            }
            
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(Theme.backGround)
        .navigationBarBackButtonHidden()
        //        }
        .onAppear{
            barHidden = true
        }
        .toolbar(content: {
            if image != nil {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Theme.icon)
                        Text("Back")
                            .font(.system(size: 20))
                            .foregroundColor(Theme.icon)
                    }
                    .onTapGesture {
                        barHidden.toggle()
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Text("Repeat")
                            .font(.system(size: 20))
                            .foregroundColor(Theme.icon)
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(Theme.icon)
                    }
                    .onTapGesture {
                        countDiseases = 6
                        image = nil
                    }
                }
            }
        })
    }
    
    func postData(uiimage: UIImage) async {
        let boundary = UUID().uuidString
        
        let session = URLSession.shared
        var urlRequest = URLRequest(url: URL(string: "\(Constants.ngrokModels)/predict/disease")!)
        
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
                var results: [ResponseDisease] = []
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
                    if let json = jsonData as? [String: String] {
                        
                        let str = json["response"] ?? " "
                        let strCopy = str.replacingOccurrences(of: " ", with: "")
                        let array = strCopy.split(separator: ",")
                        for i in 0..<array.count {
                            let acc = Double(array[i]) ?? 0.0
                            let resultAcc: Int = (acc > 0) ? Int((acc + 5) * 10) % 100 : (acc > -5) ? Int((5 + acc) * 10) : 0
                            if resultAcc < 60 {
                                countDiseases -= 1
                            }
                            let result = ResponseDisease(id: i, name: disease_names[i], acc: resultAcc)
                            
                            results.append(result)
                        }
                    }
                    let resultsCopy = results
                    DispatchQueue.main.async {
                        resultsML = resultsCopy
                        isInfoLoading = false
                    }
                } catch {
                    print(error)
                }
            } else {
                print(error ?? "error")
            }
        }).resume()
    }
    
    func recognizeSick() {
        Task {
            await postData(uiimage: image!)
        }
    }
    
}
