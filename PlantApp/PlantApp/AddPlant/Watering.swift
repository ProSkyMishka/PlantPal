//
//  Watering.swift
//  PlantApp
//
//  Created by Lucy Rez on 12.07.2024.
//

import Foundation
import SwiftData

@Model
class Watering {
    var date: Date = Date()
    var plant: Plant?
    
    init(date: Date, plant: Plant? = nil) {
        self.date = date
        self.plant = plant
    }
}
