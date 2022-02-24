//
//  ViewController.swift
//  Project21
//
//  Created by Raphael de Jesus on 23/02/22.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))
    }
    
    
    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Yeah!")
            } else {
                print("Holy Crow, why you did it!")
            }
        }
    }
    
    @objc func scheduleLocal() {
        
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        
        content.title = "Late wake up call"
        content.body = "The early bird catches the worm, but the second cat gets the cheese"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = .default
        
//        var dateComponent = DateComponents()
//        dateComponent.hour = 14
//        dateComponent.minute = 30
//
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request)
        
    }
    
    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let show = UNNotificationAction(identifier: "show", title: "Tell me more...", options: .foreground)
        
        let category = UNNotificationCategory(identifier: "alarm", actions: [show], intentIdentifiers: [], options: [])
        
        center.setNotificationCategories([category])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        if let custonData = userInfo["customData"] as? String {
            print("Custon data received \(custonData)")
            
            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
//                the user swiped to unlock
                print("Default indentifier")
                
            case "show":
                print("show more information")
                
            default:
                break
            }
        }
        
        completionHandler()
    }

}

