//
//  Plant.swift
//  PlantApp
//
//  Created by Lucy Rez on 12.07.2024.
//

import Foundation
import SwiftData

@Model
class Plant: Comparable {
    static func < (lhs: Plant, rhs: Plant) -> Bool {
        return lhs.name < rhs.name;

    }
    
    var serverId: String = ""
    var name: String = ""
    var desc: String = ""
    var humidity: String = ""
    var temp: String = ""
    var MLID: String = ""
    var imageURL: String = ""
    var seconds: Int = 0
    var watering: [Watering]? = [Watering]()
    @Attribute(.externalStorage) var image: Data?
    
    init(serverId: String, desc: String, humidity: String, temp: String, MLID: String, imageURL: String, seconds: Int, name: String) {
        self.serverId = serverId
        self.desc = desc
        self.humidity = humidity
        self.temp = temp
        self.MLID = MLID
        self.imageURL = imageURL
        self.seconds = seconds
        self.name = name
    }
}

