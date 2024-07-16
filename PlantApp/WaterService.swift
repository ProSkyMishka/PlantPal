//
//  WaterService.swift
//  PlantApp
//
//  Created by Lucy Rez on 16.07.2024.
//

import Foundation


class WaterService {
    static let shared = WaterService()
    
    func water(ip: String, time: Int) {
        var request = URLRequest(url: URL(string: "http://\(ip)/servo=\(time)")!)
        
        URLSession.shared.dataTask(with: request) {data, response, error in
            if let resp = response as? HTTPURLResponse {
                print(resp.statusCode)
            }
        }
        .resume()
    }
}
