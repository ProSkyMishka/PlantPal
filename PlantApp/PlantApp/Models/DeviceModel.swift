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
    
    var ssid: String = ""
    var hashedPassword: String = ""
    var ip: String = ""
    var plants: [Plant] = [Plant]()
    
    init(ssid: String, password: String, ip: String = "") {
        self.ssid = ssid
        self.hashedPassword = hashPassword(password)
        self.ip = ip
    }
    
    private func hashPassword(_ password: String) -> String{
        return password
    }
    
    func getPassword() -> String{
        return hashedPassword
    }
    
}
