//
//  InformationForPlant.swift
//  PlantApp
//
//  Created by Lucy Rez on 08.07.2024.
//

import SwiftUI

struct InformationForPlant: View {
    @Bindable var plant: Plant
    @State var notIsEdit = true
    @State var isPresented = false
    @State var isEditOpen = false
    @Binding var barHidden: Bool
    @Environment(\.dismiss) private var dismiss
    @State var textInRepeat = "Never"
    @State var nextWatering: Date = Date()
    // @State var replay: RepeatWatering

    var body: some View {
        ScrollView{
            Image(uiImage: UIImage(data: plant.image ?? Data()) ?? UIImage())
                .resizable()
                .frame(width: 180, height: 180)
                .cornerRadius(8)
            
            PlantInfoField(textTitle: "Name", text: $plant.name, notIsEdit: notIsEdit)
            PlantInfoField(textTitle: "Description", text: $plant.desc, notIsEdit: notIsEdit)
            PlantInfoField(textTitle: "Recommended Temperature", text: $plant.temp, notIsEdit: notIsEdit)
            PlantInfoField(textTitle: "Recommended Humidity", text: $plant.humidity, notIsEdit: notIsEdit)
            
            
            ZStack{
                HStack{
                    VStack(alignment: .leading){
                        Text("Last watered")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Theme.textBrown)
                        
                        
                        if let dateNow = plant.watering.filter({$0 <= Date()}).last  {
                            Text(DateTimeFormatter.shared.toString(date: dateNow))
                                .font(.system(size: 20))
                        } else {
                            Text("None")
                                .font(.system(size: 20))
                                .foregroundColor(Theme.textColor)
                        }
                    }.padding(.leading, 20)
                    
                    Spacer()
                    
                    Button(action:{
                        addEventNow()
                        //plant.lastWatered = Date.now
//                        WaterService.shared.water(ip: plant.device!.ip, time: plant.seconds)
                        
                    }){
                        HStack{
                            Image(systemName: "drop.fill")
                                .foregroundColor(.white)
                            Text("Water")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 29)
                        .padding(.vertical,8)
                        .background(Theme.buttonColor)
                        .cornerRadius(18)
                    }
                    .padding(.all, 10)
                    .disabled(plant.device == nil)
                }
            }
            ZStack{
                HStack{
                    Text("Next")
                        .font(.system(size: 20, weight: .bold))
                        .padding(.all, 15)
                        .foregroundColor(Theme.textBrown)
                    Spacer()
                    
                    DatePicker("", selection: $nextWatering).padding(.trailing, 10)
                    
                    
                }
            }
            HStack{
                VStack {
                    
                Text("Repeat (days)")
                    .font(.system(size: 20, weight: .bold))
                    .padding(.leading, 15)
                    .foregroundColor(Theme.textBrown)
                                    
                    MyStepper(value: $plant.waterInterval, onChange: updateEventList, minValue: 1)
                    .onChange(of: plant.waterInterval) {
                        print("DEBUG")
                        let content = UNMutableNotificationContent()
                        content.title = "Время полить ваше растение"
                        content.subtitle = "Похоже, ему нужна вода"
                        content.categoryIdentifier = "ACTION"
                        content.sound = UNNotificationSound.default
                        let filtered = plant.watering.filter({$0 > Date()})
                        if !filtered.isEmpty {
                            plant.watering.removeAll(where: {$0 > Date()})
                        }
                        for i in 1..<10 {
                            plant.watering.append( Date(timeInterval: TimeInterval(86400 * i * plant.waterInterval), since: Date.now))
                        }
                        // show this notification five seconds from now
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(86400 * plant.waterInterval), repeats: false)
                        
                        let waterAction = UNNotificationAction(identifier: "WATER", title: "Water", options: [])
                        
                        UNUserNotificationCenter.current().setNotificationCategories([UNNotificationCategory(identifier: "ACTION", actions: [waterAction], intentIdentifiers: [], options: [])])

                        // choose a random identifier
                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                        // add our notification request
                        UNUserNotificationCenter.current().add(request)
                    }
                }
                
                Spacer()
                
                VStack {
                    Text("Number of repeats")
                        .font(.system(size: 20, weight: .bold))
                        .padding(.leading, 15)
                        .foregroundColor(Theme.textBrown)
                    
                    MyStepper(value: $plant.numberOfRepeats, onChange: updateEventList)
                }
            }
            
            
            HStack{
                Text("Device:")
                    .font(.system(size: 20, weight: .bold))
                    .padding(.all, 15)
                    .foregroundColor(Theme.textBrown)
                Spacer()
                
                if (plant.device != nil) {
                    Text(plant.device!.deviceId)
                        .font(.system(size: 20, weight: .bold))
                        .padding(.all, 15)
                        .foregroundColor(Theme.textBrown)
                } else {
                    Text(LocalizedStringKey("No device"))
                        .font(.system(size: 20, weight: .bold))
                        .padding(.all, 15)
                        .foregroundColor(Theme.textBrown)
                }
            }
            
            NavigationLink{
                DeviceListView(plant: plant)
            } label: {
                HStack {
                    Image(systemName: "shareplay")
                        .resizable()
                        .frame(width: 30, height: 30)
                    
                    Text("Device Settings")
                        .font(.system(size: 22))
                }
            }
            .foregroundColor(Theme.buttonColor)
            
        }
        .padding()
        .background(Theme.backGround)
        .onAppear {
            barHidden = true
        }
        .navigationBarBackButtonHidden()
        .toolbarBackground(Theme.backGround, for: .automatic)
        .toolbar(content: {
            ToolbarItem(placement: .automatic) {
                Text("\(plant.name) Info")
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
                    barHidden.toggle()
                    dismiss()
                }
            }
        })
//        .padding([.horizontal])
    }
    
    func updateEventList() {
        guard let _ = plant.device else {return}
        let session = URLSession.shared
        var urlRequest = URLRequest(url: URL(string: "\(Constants.urlServer)/dates")!)
//        var urlRequest = URLRequest(url: URL(string: "http://\(Constants.ip):8080/dates")!)
        
        urlRequest.httpMethod = "POST"
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["startDate": ServerDateTimeFormatter.shared.toString(date: nextWatering), "interval": plant.waterInterval, "repeats": plant.numberOfRepeats, "seconds": plant.seconds, "device_id": plant.device!.deviceId] as [String : Any]
        
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body)
        session.dataTask(with: urlRequest) { data, response, error in
            if response is HTTPURLResponse {
                do {
                    let m = try JSONDecoder().decode([DateModel].self, from: data!)
                    print(m)
                } catch {
                    print(error)
                }
            }
            
        }.resume()
    }
    
    func addEventNow() {
        let session = URLSession.shared
        var urlRequest = URLRequest(url: URL(string: "\(Constants.urlServer)/water")!)
//        var urlRequest = URLRequest(url: URL(string: "http://\(Constants.ip):8080/water")!)
        
        urlRequest.httpMethod = "POST"
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["seconds": plant.seconds, "device_id": plant.device!.deviceId] as [String : Any]
        
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body)
        session.dataTask(with: urlRequest) { data, response, error in
            if response is HTTPURLResponse {
                do {
                    let m = try JSONDecoder().decode([DateModel].self, from: data!)
                    print(m)
                } catch {
                    print(error)
                }
            }
            
        }.resume()
    }
}
