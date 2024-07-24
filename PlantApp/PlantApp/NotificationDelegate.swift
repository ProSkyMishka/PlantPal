//
//  NotificationDelegate.swift
//  PlantApp
//
//  Created by ProSkyMishka on 16.07.2024.
//

import Foundation
import UserNotifications

class NotificationDelegate: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .banner, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.actionIdentifier == "WATER" {
            print("Watering is here...")
            WaterService.shared.water(ip: "", time: 10)
        }
        
        completionHandler()
    }
}
