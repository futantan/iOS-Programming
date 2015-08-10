//
//  HypnosisView.swift
//  Hypnosister
//
//  Created by luckytantanfu on 8/10/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

import UIKit

class HypnosisView: UIView {
    
    private var circleColor: UIColor {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        circleColor = UIColor.lightGrayColor()
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        circleColor = UIColor.lightGrayColor()
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let red = CGFloat(Float(arc4random() % 100) / 100.0)
        let green = CGFloat(Float(arc4random() % 100) / 100)
        let blue = CGFloat(Float(arc4random() % 100) / 100)
        
        let randomColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        
        circleColor = randomColor
    }

    override func drawRect(rect: CGRect) {
        let bounds = self.bounds
        let center = CGPoint(x: bounds.origin.x + bounds.size.width / 2.0, y: bounds.origin.y + bounds.size.height / 2.0)
        let maxRadius = hypot(bounds.size.width, bounds.size.height)
        
        let path = UIBezierPath()
        
        for (var currentRadius = maxRadius; currentRadius > 0; currentRadius = currentRadius - CGFloat(20)) {
            path.moveToPoint(CGPointMake(bounds.width/2.0 + currentRadius, bounds.height/2.0))
            path.addArcWithCenter(center, radius: currentRadius, startAngle: CGFloat(0.0), endAngle: CGFloat(M_PI * 2.0), clockwise: true)
        }
        
        path.lineWidth = 10
        circleColor.setStroke()
        path.stroke()
        
    }
}
