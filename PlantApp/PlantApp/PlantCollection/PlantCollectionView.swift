//
//  PlantCollectionView.swift
//  PlantApp
//
//  Created by Lucy Rez on 08.07.2024.
//

import SwiftUI
import SwiftData


struct PlantCollectionView: View {    
    @State var selectId = UserDefaults.standard.string(forKey: "SelectDeviceId")
    @State var select: SensorDevice?
    @Environment(EventStore.self) private var eventStore
    @Environment(\.modelContext) private var modelContext: ModelContext
    @State var sortAlphabet: Bool = false
    @State var sorted_enabled: [Plant] = []
    @State var search = ""
    @Binding var barHidden: Bool
    @FocusState var isFocused: Bool
    @State var showSearch: Bool = false
    

    var body: some View {
        NavigationStack {
            VStack {
                if (!showSearch) {
                    HStack {
                        
                        Text("Flowers Collection")
                            .font(.system(size: 30))
                            .bold()
                            .foregroundColor(Theme.textAzure)
                        
                        Spacer()
                        
                        Button(action: {
                            sortAlphabet.toggle()
                        }, label: {
                            Image(systemName: "arrow.up.arrow.down")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .padding(.horizontal, 10)
                                .background(Theme.backGround)
                        })
                    }
                }
                
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Theme.textColor)
                        
                        TextField("", text: $search, prompt: Text("Search").foregroundColor(Theme.textColor))
                            .foregroundColor(Theme.textColor)
                            .font(.system(size: 20))
                            .onChange(of: isFocused) {
                                withAnimation {
                                    showSearch = isFocused
                                }
                            }
                    }
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    .background(Theme.search)
                    .cornerRadius(10)
                    .focused($isFocused)
                    
                    if (showSearch) {
                        Button(action: {
                            withAnimation {
                                isFocused = false
                            }
                           
                        }) {
                            Text("Cancel")
                                .foregroundColor(Theme.icon)
                                .font(.system(size: 20))
                        }
                    }
                }
                .transition(.slide)
                
                HStack(alignment: .center) {
                    Text("Temp: \(String(select?.temp ?? 0.0)) ºC")
                        .font(.subheadline)
                    
                    Spacer()
                    
                    Text("Humidity: \(String(select?.humidity ?? 0.0))%")
                        .font(.subheadline)
//                    Text("Name device: " + String(select?.name ?? "Nope"))
//                        .font(.subheadline)
                }
                .padding()

                ScrollView {
                    ZStack {
                        FlowerListView(sort: sortAlphabet ? [SortDescriptor(\Plant.name)] : [], search: $search, barHidden: $barHidden)
                    }
                }
            }
            .transition(.slide)
            .padding(.horizontal)
            .background(Theme.backGround)
            .foregroundColor(Theme.textBrown)
        }
        .onAppear {
            Task {
                try await getSensor()
            }
        }
    }

    func getSensor() async throws {
        let accessToken = UserDefaults.standard.string(forKey: "AccessToken")
        guard let url = URL(string: "https://api.iot.yandex.net/v1.0/devices/\(selectId ?? "")") else {
            throw Errors.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        guard let access = accessToken else {
            throw Errors.notAuth
        }
        
        request.setValue("Bearer \(access)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(Errors.someRequestError)
                return
            }
            
            guard let data = data else {
                print(Errors.noDataReceived)
                return
            }
            
            do {
                if let httpResponse = response as? HTTPURLResponse {
                    print("HTTP Status Code: \(httpResponse.statusCode)")
                    if httpResponse.statusCode == 401 {
                        print(Errors.notAuth)
                        return
                    }
                }
                
                let responseString = String(data: data, encoding: .utf8) ?? "No response string"
//                print("Response String: \(responseString)")
                
                let ourDevice = try JSONDecoder().decode(IoTDevice.self, from: data)
                var tempDevices: [SensorDevice] = []
                var device = SensorDevice(id: ourDevice.id, name: ourDevice.name, temp: 0.0, humidity: 0.0)
                if let properties = ourDevice.properties {
                    for j in properties {
                        if let state = j?.state {
                            if state.instance == "temperature" {
                                if case .double(let value) = state.value {
                                    device.temp = value
                                }
                            } else if state.instance == "humidity" {
                                if case .double(let value) = state.value {
                                    device.humidity = value
                                }
                            }
                        }
                    }
                    if device.temp != 0.0 || device.humidity != 0.0 {
                        tempDevices.append(device)
                    }
                }
                let deviceCopy = device
                DispatchQueue.main.async {
                    self.select = deviceCopy
                }
            } catch {
                print("Failed to parse JSON: \(error)")
            }
        }
        task.resume()
    }
}

enum Errors: Error {
    case badUrl
    case notAuth
    case someRequestError
    case noDataReceived
}
