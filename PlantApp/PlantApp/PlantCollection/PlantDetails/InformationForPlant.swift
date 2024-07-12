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
    @State var date = Date()
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
                        VStack{
                            Text("Last watered")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(Theme.textBrown)
                            
                            Text(DateTimeFormatter.shared.toString(date: Date()))
                                .font(.system(size: 20))
                                .foregroundColor(Theme.textColor)
                            
//                            if plant.lastWatered != nil {
//                                Text(DateTimeFormatter.shared.toString(date: plant.lastWatered!))
//                                    .font(.system(size: 20))
//                            } else {
//                                Text("None")
//                                    .font(.system(size: 20))
//                                    .foregroundColor(Theme.textColor)
//                            }
                        }.padding(.leading, 20)
                        Spacer()
                        Button(action:{
                            //plant.lastWatered = Date.now
                            
                            // TODO: Call server with new date
                            
                        }){
                            HStack{
                                Image(systemName: "drop.fill")
                                    .foregroundColor(.white)
                                Text("Water")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal, 24)
                            .padding(.vertical,8)
                            .background(Theme.buttonColor)
                            .cornerRadius(18)
                        }.padding(.all, 10)
                    }
                }
                ZStack{
                    HStack{
                        Text("Next watering")
                            .font(.system(size: 20, weight: .bold))
                            .padding(.all, 15)
                            .foregroundColor(Theme.textBrown)
                        Spacer()
                        DatePicker("", selection: $date).padding(.trailing, 10)
                        //DatePicker("", selection: $plant.nextWatering).padding(.trailing, 10)
                    }
                }
                HStack{
                    Text("Repeat")
                        .font(.system(size: 20, weight: .bold))
                        .padding(.leading, 15)
                        .foregroundColor(Theme.textBrown)
                    
                    Spacer()

                    HStack{
                        
                        Menu(){
                            Button("Every month", action: {textInRepeat = "Every month"})
                            Button("Every week", action: {textInRepeat = "Every week"})
                            Button("Every day", action: {textInRepeat = "Every day"})
                            Button("Never", action: {textInRepeat = "Never"})
                            
                            // TODO: функция для обновления значения plant.replay
                        }label:{
                            Label(LocalizedStringKey(textInRepeat), systemImage: "timer")
                                .padding(.trailing, 10)
                                .foregroundColor(Theme.textBrown)
                            }
                    }
                }
                Spacer()
            }
            .background(Theme.backGround)
            .onAppear {
                barHidden = true
            }
            .navigationBarBackButtonHidden()
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
            
        }
}
