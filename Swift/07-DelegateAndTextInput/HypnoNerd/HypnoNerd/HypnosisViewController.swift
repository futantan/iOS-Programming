//
//  HypnosisViewController.swift
//  HypnoNerd
//
//  Created by luckytantanfu on 8/13/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

import UIKit

class HypnosisViewController: UIViewController {
    
    override func loadView() {
        let backgroundView = HypnosisView()
        
        let textFieldRect = CGRectMake(40, 70, 240, 30)
        let textField = UITextField(frame: textFieldRect)
        
        textField.borderStyle = UITextBorderStyle.RoundedRect
        textField.placeholder = "Hypnotize me"
        textField.returnKeyType = UIReturnKeyType.Done
        
        textField.delegate = self
        
        backgroundView.addSubview(textField)
        self.view = backgroundView
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
        println("HypnosisViewController loaded its view.")
    }
    
    func drawHypnoticeMessage(message: String) {
        for i in 1..<20 {
            let messageLabel = UILabel()
            messageLabel.backgroundColor = UIColor.clearColor()
            messageLabel.textColor = UIColor.whiteColor()
            messageLabel.text = message
            messageLabel.sizeToFit()
            
            let width = Int(self.view.bounds.size.width - messageLabel.bounds.size.width)
            let x = CGFloat(random() % width)
            let height = Int(self.view.bounds.size.height - messageLabel.bounds.size.height)
            let y = CGFloat(random() % height)
            
            var frame = messageLabel.frame
            frame.origin = CGPointMake(x, y)
            messageLabel.frame = frame
            
            self.view.addSubview(messageLabel)
            
            var motionEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: UIInterpolatingMotionEffectType.TiltAlongHorizontalAxis)
            motionEffect.minimumRelativeValue = -25
            motionEffect.maximumRelativeValue = 25
            messageLabel.addMotionEffect(motionEffect)
            
            motionEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: UIInterpolatingMotionEffectType.TiltAlongVerticalAxis)
            motionEffect.minimumRelativeValue = -25
            motionEffect.maximumRelativeValue = 25
            messageLabel.addMotionEffect(motionEffect)
        }
    }
}

extension HypnosisViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        drawHypnoticeMessage(textField.text)
        textField.text = ""
        textField.resignFirstResponder()
        return true
    }
}
