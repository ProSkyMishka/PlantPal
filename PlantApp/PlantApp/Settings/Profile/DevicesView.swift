import SwiftUI

struct DevicesView: View {
    @State private var devices: [SensorDevice] = []
    @State var selectId = UserDefaults.standard.string(forKey: "SelectDeviceId") ?? ""
    @Binding var barHidden: Bool
    @State private var errorMessage: String?
    @Environment(\.dismiss) private var dismiss
    @State private var isExpanded = false
    @State private var isLogged: Bool = ("" != UserDefaults.standard.string(forKey: "AccessToken") ?? "")
    
    var body: some View {
        NavigationView {
            VStack {
                if errorMessage != nil || !isLogged {
                    VStack {
                        Text(errorMessage ?? "")
                        DisclosureGroup("Why should I login?", isExpanded: $isExpanded) {
                            Text("I should login, because... Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                                .lineSpacing(7)
                                .padding()
                                .frame(width: 360, height: 135)
                                .background(.gray)
                                .cornerRadius(15)
                                .tint(.white)
                        }
                        .padding()
                        
                        NavigationLink(destination: Profile(barHidden: $barHidden, isLogged: $isLogged), label: {
                            Text("Log in")
                                .font(.system(size: 20))
                                .padding()
                                .tint(.white)
                        })
                        .background(.black)
                        .cornerRadius(20)
                    }
                }
                
                if isLogged {
                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                        ForEach(devices) { device in
                        label: do {
                            ZStack {
                                Rectangle()
                                    .frame(width: 140, height: 170)
                                    .cornerRadius(20)
                                //                                .foregroundColor(Theme.pink)
                                    .padding(.vertical, 10)
                                    .foregroundColor(selectId == device.id ? Color.green : Color.clear)
                                VStack(alignment: .center) {
                                    Text(device.name)
                                        .font(.headline)
                                    Text("Temp: " + String(device.temp))
                                        .font(.subheadline)
                                    Text("Humidity: " + String(device.humidity))
                                        .font(.subheadline)
                                }
                                .tint(.black)
                            }
                            .onTapGesture {
                                if selectId == device.id {
                                    selectId = ""
                                } else {
                                    selectId = device.id
                                }
                                UserDefaults.standard.setValue(selectId, forKey: "SelectDeviceId")
                            }
                        }
                        }
                    }
                    .navigationTitle("Devices")
                    .onAppear {
//                        print("Access Token: \(UserDefaults.standard.string(forKey: "AccessToken") ?? "No Access Token")")
                        loadDevices()
                    }
                }
                
                Spacer()
            }
        }
        .onAppear {
            print("appear \(isLogged)")
            barHidden = true
        }
//
        .navigationBarBackButtonHidden()
        .toolbar(content: {
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
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    if UserDefaults.standard.string(forKey: "AccessToken") != "" && UserDefaults.standard.string(forKey: "AccessToken") != nil {
                        Text("Sign out")
                            .font(.system(size: 20))
                            .foregroundColor(Theme.icon)
                            .onTapGesture {
                                UserDefaults.standard.setValue("", forKey: "AccessToken")
                                devices = []
                                isLogged = false
//                                barHidden = false
//                                dismiss()
                            }
                    }
                }
            }
        })
    }
    
    func loadDevices() {
        guard let url = URL(string: "https://api.iot.yandex.net/v1.0/user/info") else {
            errorMessage = "Invalid URL"
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        guard let access = UserDefaults.standard.string(forKey: "AccessToken") else {
            errorMessage = "You must be logged in the Profile field"
            return
        }
//        errorMessage = "\(access) \(UserDefaults.standard.string(forKey: "AccessToken") ?? "hi")"
        request.setValue("Bearer \(access)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Error: \(error.localizedDescription)"
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "No data received"
                }
                return
            }
            
            do {
                if let httpResponse = response as? HTTPURLResponse {
                    print("HTTP Status Code: \(httpResponse.statusCode)")
                    if httpResponse.statusCode == 401 {
                        DispatchQueue.main.async {
                            self.errorMessage = "Unauthorized: Check your access token"
                        }
                        return
                    }
                }
                
                _ = String(data: data, encoding: .utf8) ?? "No response string"
//                print("Response String: \(responseString)")
                
                let ourDevices = try JSONDecoder().decode(UserInfo.self, from: data).devices
                var tempDevices: [SensorDevice] = []
                for i in ourDevices {
                    var device = SensorDevice(id: i.id, name: i.name, temp: 0.0, humidity: 0.0)
                    if let properties = i.properties {
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
                    }
                    if device.temp != 0.0 || device.humidity != 0.0 {
                        tempDevices.append(device)
                    }
                }
                DispatchQueue.main.async {
                    if tempDevices.count > 0 && selectId == "" {
                        selectId = tempDevices[0].id
                        UserDefaults.standard.set(selectId, forKey: "SelectDeviceId")
                    }
                    self.devices = tempDevices
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "You haven't got sensor devices"
                }
                print("Failed to parse JSON: \(error)")
            }
        }
        task.resume()
    }
}
