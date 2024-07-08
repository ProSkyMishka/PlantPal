//
//  HistoryItemModel.swift
//  PlantApp
//
//  Created by Lucy Rez on 08.07.2024.
//

import Foundation

struct ScheduleItemModel: Identifiable {
    var id: UUID = UUID()
    var name: String
    var schedule_time: String
    var moisture: String
    var moistureInt: Int
    var iconName: String = "trash.fill"
}
