//
//  ConnectDeviceService.swift
//  PlantApp
//
//  Created by ProSkyMishka on 17.07.2024.
//

import Foundation
import SwiftData


struct idDTO: Codable {
    var id: String
}


class ConnectDeviceService {
    static let shared = ConnectDeviceService()
    
    func connect(ssid: String, password: String, context: ModelContext) {
        let request = URLRequest(url: URL(string: "http://192.168.4.1/ssid=\(ssid)/password=\(password)")!)
        
        URLSession.shared.dataTask(with: request) {data, response, error in
            if let resp = response as? HTTPURLResponse {
                do {
                    let dto = try JSONDecoder().decode(idDTO.self, from: data!)
                    
                    let device: Device = Device(deviceId: dto.id)
                    context.insert(device)
                } catch {
                    print(error)
                }
            }
        }
        .resume()
    }
}
