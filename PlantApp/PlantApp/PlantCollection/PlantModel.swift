//
//  PlantModel.swift
//  PlantApp
//
//  Created by Lucy Rez on 08.07.2024.
//

import Foundation

struct PlantBaseModel: Identifiable, Comparable {
    static func < (lhs: PlantBaseModel, rhs: PlantBaseModel) -> Bool {
        return lhs.name < rhs.name;
    }
    
    var id: UUID = UUID()
    var name: String
    var description: String
    var lastWatered: Date?
    var url: String
    var temperatureRange: String
    var humidity: String
    var waterInterval: Int
    var nextWatering: Date
    var replay: RepeatWatering
}

enum RepeatWatering: String {
    case never = "Never"
    case everyDay = "Every Day"
    case everyWeek = "Every Week"
    case everyMonth = "Every Month"
}
