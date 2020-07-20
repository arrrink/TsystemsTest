//
//  ScheduleViewController.swift
//  TsystemsTest
//
//  Created by Арина Нефёдова on 19.07.2020.
//  Copyright © 2020 Арина Нефёдова. All rights reserved.
//

import UIKit
import UserNotifications

class ScheduleViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    var date : Date?
    let userNotificationCenter = UNUserNotificationCenter.current()
    var movieName: String = ""
   
   
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    @IBAction func dateCheckPicker(_ sender: UIDatePicker) {
        date = sender.date
    }
    
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBAction func saveButton(_ sender: UIDatePicker) {
        
        
        guard date != nil else {
            return
        }
        self.sendNotification(date!, movieName)
    
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Schedule"
        movieNameLabel.text = movieName
        
        self.userNotificationCenter.delegate = self
        self.requestNotificationAuthorization()
        
    }
    
    func requestNotificationAuthorization() {
         let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
         
         self.userNotificationCenter.requestAuthorization(options: authOptions) { (success, error) in
             if let error = error {
                 print("Error: ", error)
             }
         }
     }
     
    

    func sendNotification(_ d: Date, _ s: String) {
         let notificationContent = UNMutableNotificationContent()
         notificationContent.title = "T-systems test"
        notificationContent.body = "Let's watch \(s)"
         notificationContent.badge = NSNumber(value: 3)
        notificationContent.sound = UNNotificationSound.default
 
         let calendar = Calendar.current
        
        let comp2 = calendar.dateComponents([.year,.month,.day,.hour,.minute], from: d)
         let trigger = UNCalendarNotificationTrigger(dateMatching: comp2, repeats: true)
         
         
         let request = UNNotificationRequest(identifier: "testNotification",
                                             content: notificationContent,
                                             trigger: trigger)
         
         userNotificationCenter.add(request) { (error) in
             if let error = error {
                 print("Notification Error: ", error)
             }
         }
     }
     
     func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
         completionHandler()
     }

     func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
         completionHandler([.alert, .badge, .sound])
     }
}
