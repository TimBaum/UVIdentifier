//
//  NotificationManager.swift
//  uv.identifier
//
//  Created by Tim Baum on 14.04.22.
//

import Foundation
import UserNotifications

/**
 Manages the notifications for the applications, that can be enabled by the user
 */
class NotificationManager {
    
    var activatedNotification: Int
    //0 - off, 1 - alerts
    let notificationDescriptions = ["🛎 - Off", "🛎 - Alert"]
    private var notificationsAllowed = false
    private var recurringNotificationEnabled = false
    
    init(activatedNotification: Int) {
        self.activatedNotification = activatedNotification
        //Ask for authorization to send notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                self.notificationsAllowed = true
            }
            else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    /**
     Disables notifications and removes all pending ones
     */
    func disableNotification() -> Void {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        self.activatedNotification = 0
    }
    
    /**
     Sets the current notifications status to a given integer
     */
    func enableNotifications(newNotification: Int, uvManager: UVManager) -> Void {
        //If notifications are not allowed: abort
        if !notificationsAllowed {
            print("Enable notifications to activate")
            return
        }
        if newNotification == 0 {
            disableNotification()
        }
        else if newNotification == 1 {
            guard let maxTime = uvManager.uvTimes.max() else {
                print("No information available")
                return
            }
            //Schedule both notifications
            scheduleAlertNotification(time: maxTime.getHour(), uvIndex: maxTime.uv)
            scheduleRecurrentNotification()
            self.activatedNotification = 1
        }
    }
    
    /**
     Schedules a recurring notification for the user to check the app. This could be improved by background acticity or push notifications from a server to display the actual information for that day in the notification.
     */
    private func scheduleRecurrentNotification() {
        
        if recurringNotificationEnabled == true {
            return
        }
        
        let title = "Don't get a sunburn today!"
        let body = "Get the latest information about the uv radiation now!"
        
        scheduleNotification(title: title, body: body, hour: 9, recurring: true)

        self.recurringNotificationEnabled = true
    }
    
    /**
     Schedule a notification using UNUserNotificationCenter
     */
    private func scheduleNotification(title: String, body: String, hour: Int, recurring: Bool) -> Void {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        
        dateComponents.hour = hour
        
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents, repeats: recurring)
        
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
    
    /**
     Schedule a notification using the highest uv Index at that day
     */
    func scheduleAlertNotification(time: Int, uvIndex: Float) {
        
        let title = "Alert"
        let body = "The maximum UVIndex today will be \(uvIndex) at \(time). Take care."
        
        scheduleNotification(title: title, body: body, hour: time-2, recurring: false)
    }
}

