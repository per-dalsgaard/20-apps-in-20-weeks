//
//  ViewController.swift
//  NewNotifications
//
//  Created by Per Kristensen on 19/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Notification access granted!")
            } else {
                print(error?.localizedDescription ?? "TODO")
            }
        }
    }
    @IBAction func notifyButtonPressed(_ sender: UIButton) {
        scheduleNotification(inSeconds: 5, completion: { success in
            if success {
                print("Successfully scheduled notification")
            } else {
                print("Erro scheduling notification")
            }
        })
    }
    
    func scheduleNotification(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ()) {
        guard let imageUrl = Bundle.main.url(forResource: "rick_grimes", withExtension: "gif") else {
            completion(false)
            return
        }
        
        var attachment: UNNotificationAttachment
        attachment = try! UNNotificationAttachment(identifier: "myNotification", url: imageUrl, options: .none)
        
        let notif = UNMutableNotificationContent()
        notif.categoryIdentifier = "myNotificationCategory"
        
        notif.title = "New notifications"
        notif.subtitle = "These are great!"
        notif.body = "The new notification options in iOS 10 are what I've always dreamed of!"
        notif.attachments = [attachment]
        
        let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: "myNotification", content: notif, trigger: notifTrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil {
                print(error.debugDescription)
                completion(false)
            } else {
                completion(true)
            }
        })
    }
}

