//
//  PlantCollectionViewModel.swift
//  PlantApp
//
//  Created by Lucy Rez on 11.07.2024.
//

import Foundation

class PlantCollectionViewModel: ObservableObject {
    @Published var plants: [PlantBaseModel] = [
        PlantBaseModel(name: "Apple", description: "Tree", lastWatered: Date(), url: "daisy", temperatureRange: "15 - 25", humidity: "65", waterInterval: 5, nextWatering: Date(), replay: .everyDay),
        PlantBaseModel(name: "Rosa", description: "Flower", lastWatered: Date(), url: "daisy", temperatureRange: "15 - 25", humidity: "65", waterInterval: 5, nextWatering: Date(), replay: .everyDay),
        PlantBaseModel(name: "Bereza", description: "Tree", lastWatered: Date(), url: "daisy", temperatureRange: "15 - 25", humidity: "65", waterInterval: 5, nextWatering: Date(), replay: .everyDay)
    ]
    
    @Published var search = ""
    
    var filteredPlants: [PlantBaseModel] {
            guard !search.isEmpty else { return plants }
            return plants.filter { plant in
                plant.name.lowercased().contains(search.lowercased()) || plant.name.maxSubstring(b: search)
            }
        }
}
