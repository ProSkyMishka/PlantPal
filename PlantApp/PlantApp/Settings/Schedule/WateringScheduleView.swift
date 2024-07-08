//
//  WateringHistoryView.swift
//  PlantApp
//
//  Created by Lucy Rez on 08.07.2024.
//

import SwiftUI

struct WateringScheduleView: View {
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
                                            .bold()
                                        Text(flower.schedule_time)
                                            .foregroundColor(.gray)
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
                   
                    
                }
                .scrollContentBackground(.hidden)
    
        }
            .navigationTitle("Schedule")
            .navigationBarTitleDisplayMode(.inline)
        
    }
}

