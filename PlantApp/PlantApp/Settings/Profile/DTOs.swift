//
//  DTOs.swift
//  PlantApp
//
//  Created by Михаил Прозорский on 19.07.2024.
//

import Foundation

struct StateDeviceS: Codable {
    let instance: String
    let value: ValueType
}

enum ValueType: Codable {
    case string(String)
    case double(Double)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(Double.self) {
            self = .double(value)
        } else if let value = try? container.decode(String.self) {
            self = .string(value)
        } else {
            throw DecodingError.typeMismatch(ValueType.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Invalid type for ValueType"))
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let value):
            try container.encode(value)
        case .double(let value):
            try container.encode(value)
        }
    }
}

struct Property: Codable {
    let state: StateDeviceS?
}

struct IoTDevice: Codable {
    let id: String
    let name: String
    let type: String
    let properties: [Property?]?
    // Добавьте другие свойства, если необходимо
}

struct SensorDevice: Identifiable {
    let id: String
    let name: String
    var temp: Double
    var humidity: Double
    // Добавьте другие свойства, если необходимо
}

struct UserInfo: Codable {
    let devices: [IoTDevice]
}
