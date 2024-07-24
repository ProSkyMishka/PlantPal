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

class ServerDateTimeFormatter {
    static var shared = ServerDateTimeFormatter()
    
    private var dateFormatte = DateFormatter()
    
    init() {
        self.dateFormatte.locale = Locale(identifier: "en_GB")
        self.dateFormatte.dateFormat = "yyyy-MM-dd HH:mm"
    }
    
    func toString(date: Date) -> String {
        return dateFormatte.string(from: date)
    }
    
    func fromString(s: String) -> Date? {
        return dateFormatte.date(from: s)
    }
}

class ServerDateTimeFormatter1 {
    static var shared = ServerDateTimeFormatter1()
    
    private var dateFormatte = DateFormatter()
    
    init() {
        self.dateFormatte.locale = Locale(identifier: "en_GB")
        self.dateFormatte.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    }
    
    func convertDateStringToDate(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            return dateFormatter.string(from: date)
        }
        
        return nil
    }

}

class ServerDateTimeFormatter3 {
    static var shared = ServerDateTimeFormatter3()
    
    private var dateFormatter = DateFormatter()
    
    init() {
        self.dateFormatter.locale = Locale(identifier: "en_GB")
        self.dateFormatter.dateFormat = "dd-MM"
    }
    
    func toString(date: Date) -> String {
        return dateFormatter.string(from: date)
    }
}
