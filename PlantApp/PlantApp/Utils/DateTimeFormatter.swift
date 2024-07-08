//
//  DateTimeFormatter.swift
//  PlantApp
//
//  Created by Lucy Rez on 08.07.2024.
//

import Foundation

class DateTimeFormatter {
    static var shared = DateTimeFormatter()
    
    private var dateFormatte = DateFormatter()
    
    init() {
        self.dateFormatte.locale = Locale(identifier: "en_GB")
        self.dateFormatte.setLocalizedDateFormatFromTemplate("MMMMd HH:mm")
    }
    
    func toString(date: Date) -> String {
        return dateFormatte.string(from: date)
    }
    
}
