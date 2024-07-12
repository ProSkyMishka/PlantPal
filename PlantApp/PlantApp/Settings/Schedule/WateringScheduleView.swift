//
//  WateringHistoryView.swift
//  PlantApp
//
//  Created by Lucy Rez on 08.07.2024.
//

import SwiftUI

struct WateringScheduleView: View {
    @Binding var barHidden: Bool
    @Environment(\.dismiss) private var dismiss
    @StateObject var scheduleViewModel = ScheduleViewModel()
    
    var body: some View {
            ZStack (alignment: .center){
                List {
                    ForEach($scheduleViewModel.historyArray) {$flower in
                        NavigationLink {
                            DetailedScheduleView(flower: $flower, scheduleViewModel: scheduleViewModel)
                        } label: {
                            ZStack (alignment: .topLeading) {
                                HStack {
                                    VStack (alignment: .leading) {
                                        
                                        Text(flower.name)
                                            .foregroundColor(Theme.textBrown)
                                            .bold()
                                        Text("Scheduled on \(flower.schedule_time)")
                                            .foregroundColor(Theme.description)
                                        Divider()
                                    }
                                    
                                }
                            }
                            .tint(.primary)
                        }
                        .listRowSeparator(.hidden)
                        .swipeActions {
                            Button(action: {
                                if let ind = scheduleViewModel.historyArray.firstIndex(where: {$0.id == flower.id}) {
                                    scheduleViewModel.historyArray
                                        .remove(at: ind)
                                }
                            }){ Image(systemName: "trash.fill")}
                                .tint(.red)
                        }
                    }
                    .listRowBackground(Theme.backGround)
                }
                .scrollContentBackground(.hidden)
                .background(Theme.backGround)
    
        }
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

        
    }
}

