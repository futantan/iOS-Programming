//
//  ReminderViewController.swift
//  HypnoNerd
//
//  Created by luckytantanfu on 8/13/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

import UIKit

class ReminderViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker?
    
    @IBAction func addReminder(sender: UIDatePicker) {
        let date = self.datePicker!.date
        println("Setting a reminder for \(date)")
        let note = UILocalNotification()
        note.alertBody = "Hypnotize me!"
        note.fireDate = date
        
        UIApplication.sharedApplication().scheduleLocalNotification(note)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.tabBarItem.title = "Hypnotize"
        self.tabBarItem.image = UIImage(named: "Hypno.png")
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("ReminderViewController loaded its view.")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.datePicker?.minimumDate = NSDate(timeIntervalSinceNow: 60)
    }
    
}
