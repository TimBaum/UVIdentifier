//
//  NotificationManager.swift
//  uv.identifier
//
//  Created by Tim Baum on 14.04.22.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    var activatedNotification: Int
    //0 - off, 1 - alerts
    let notificationDescriptions = ["🛎 - Off", "🛎 - Alert"]
    private var notificationsAllowed = false
    private var recurringNotificationEnabled = false
    
    init(activatedNotification: Int) {
        self.activatedNotification = activatedNotification
        //Ask for authorization
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                self.notificationsAllowed = true
            }
            else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func disableNotification() -> Void {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        self.activatedNotification = 0
    }
    
    func enableNotifications(newNotification: Int, uvManager: UVManager) -> Void {
        if !notificationsAllowed {
            print("Enable notifications")
            return
        }
        if newNotification == 0 {
            disableNotification()
        }
        else if newNotification == 1 {
            guard let maxTime = uvManager.uv_times.max() else {
                print("No information available")
                return
            }
            print("Notification enabled")
            scheduleNotification(time: maxTime.getHour(), uvIndex: maxTime.uv)
            scheduleMorningNotification()
            self.activatedNotification = 1
        }
    }
    
    func scheduleMorningNotification() {
        
        if recurringNotificationEnabled == true {
            return
        }
        
        let content = UNMutableNotificationContent()
        content.title = "Don't get a sunburn today!"
        content.body = "Get the latest information about the uv radiation now!"
        
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        
        dateComponents.hour = 9
        
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents, repeats: true)
        
        // Create the request
        let uuidString = UUID().uuidString
        
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: content, trigger: trigger)
        
        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if error != nil {
                print("Some error")
            }
        }
        self.recurringNotificationEnabled = true
    }

    
    func scheduleNotification(time: Int, uvIndex: Float) {
        let content = UNMutableNotificationContent()
        content.title = "Alert"
        content.body = "The maximum UVIndex today will be \(uvIndex) at \(time). Take care."
        
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        
        dateComponents.hour = time - 2
        
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents, repeats: false)
        
        // Create the request
        let uuidString = UUID().uuidString
        
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: content, trigger: trigger)
        
        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if error != nil {
                print("Some error")
            }
        }
    }
}

