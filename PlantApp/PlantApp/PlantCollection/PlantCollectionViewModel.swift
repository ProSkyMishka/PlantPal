//
//  PlantCollectionViewModel.swift
//  PlantApp
//
//  Created by Lucy Rez on 11.07.2024.
//

import Foundation

class PlantCollectionViewModel: ObservableObject {
//    @Published var plants: [PlantBaseModel] = [
//        PlantBaseModel(name: "Apple", description: "Tree", lastWatered: Date(), url: "daisy", temperatureRange: "15 - 25", humidity: "65", waterInterval: 5, nextWatering: Date(), replay: .everyDay),
//        PlantBaseModel(name: "Rosa", description: "Flower", lastWatered: Date(), url: "daisy", temperatureRange: "15 - 25", humidity: "65", waterInterval: 5, nextWatering: Date(), replay: .everyDay),
//        PlantBaseModel(name: "Bereza", description: "Tree", lastWatered: Date(), url: "daisy", temperatureRange: "15 - 25", humidity: "65", waterInterval: 5, nextWatering: Date(), replay: .everyDay)
//    ]
//    
    @Published var plants: [Plant] = [Plant(serverId: "trst", desc: "Flower", humidity: "67", temp: "56", MLID: "jwygdjq", imageURL: "", seconds: 10, name: "Rose")]
    @Published var search = ""
    
    var filteredPlants: [Plant] {
            guard !search.isEmpty else { return plants }
            return plants.filter { plant in
                plant.name.lowercased().contains(search.lowercased()) || plant.name.maxSubstring(b: search)
            }
        }
}
