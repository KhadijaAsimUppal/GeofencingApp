//
//  NotificationService.swift
//  GeofencingApp
//
//  Created by Khadija Asim on 07/05/2024.
//

import Foundation
import UserNotifications

class NotificationService: NSObject {
    
    /// Requests notification permissions
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Permission granted, you can now send notifications")
            } else {
                print("Permission denied, go to the settings to grant notifications permission")
            }
        }
    }
    
    ///Sends a notification with the given title and body paramers
    func sendNotification(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "GeofenceNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
