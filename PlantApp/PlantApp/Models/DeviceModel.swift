//
//  DeviceModel.swift
//  PlantApp
//
//  Created by Lucy Rez on 15.07.2024.
//

import Foundation
import SwiftData

@Model
class Device: Comparable {
    static func < (lhs: Device, rhs: Device) -> Bool {
        return lhs.plants.count < rhs.plants.count
    }
    
    var deviceId: String = ""
    var plants: [Plant] = [Plant]()
    
    init(deviceId: String) {
        self.deviceId = deviceId
    }
    
}
