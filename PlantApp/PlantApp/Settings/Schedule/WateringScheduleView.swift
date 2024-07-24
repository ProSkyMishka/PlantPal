//
//  WateringHistoryView.swift
//  PlantApp
//
//  Created by ProSkyMishka on 08.07.2024.
//

import SwiftUI
import SwiftData

struct WateringScheduleView: View {
    @Binding var barHidden: Bool
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var modelContext: ModelContext
    
    @Query
    var plants: [Plant]
    
    var body: some View {
        List {
            ForEach(plants) {flower in
                NavigationLink {
                    DetailedScheduleView(flower: flower)
                } label: {
                    ZStack (alignment: .topLeading) {
                        HStack {
                            VStack (alignment: .leading) {
                                
                                Text(flower.name)
                                    .foregroundColor(Theme.textBrown)
                                    .bold()
                                if let dateNow = flower.watering.filter({$0 > Date()}).first {
                                    Text("Scheduled on \(DateTimeFormatter.shared.toString(date: flower.nextWatering))")
                                        .foregroundColor(Theme.description)
                                } else {
                                    Text("Not planning date yet")
                                        .foregroundColor(Theme.description)
                                }
                                
                                Divider()
                            }
                        }
                    }
                    .tint(.primary)
                }
                .listRowSeparator(.hidden)
//                .swipeActions {
//                    Button(action: {
//                        if let ind = plants.firstIndex(where: {$0.id == flower.id}) {
//                            modelContext.delete(plants[ind])
//        
//                        }
//                    }){ Image(systemName: "trash.fill")}
//                        .tint(.red)
//                }
            }
            .listRowBackground(Theme.backGround)
        }
        .scrollContentBackground(.hidden)
        .background(Theme.backGround)
        
        .navigationBarBackButtonHidden()
        .toolbar(content: {
            ToolbarItem(placement: .automatic) {
                Text("Watering Schedule")
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
        .toolbarBackground(Theme.backGround, for: .automatic)
        
    }
}

