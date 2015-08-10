//
//  HypnosisView.swift
//  Hypnosister
//
//  Created by luckytantanfu on 8/10/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

import UIKit

class HypnosisView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func drawRect(rect: CGRect) {
        let bounds = self.bounds
        let center = CGPoint(x: bounds.origin.x + bounds.size.width / 2.0, y: bounds.origin.y + bounds.size.height / 2.0)
        let maxRadius = min(bounds.size.width, bounds.size.height) / 2.0
        
        let path = UIBezierPath()
        
        for (var currentRadius = maxRadius; currentRadius > 0; currentRadius = currentRadius - CGFloat(20)) {
            path.moveToPoint(CGPointMake(bounds.width/2.0 + currentRadius, bounds.height/2.0))
            path.addArcWithCenter(center, radius: currentRadius, startAngle: CGFloat(0.0), endAngle: CGFloat(M_PI * 2.0), clockwise: true)
        }
        
        path.lineWidth = 10
        UIColor.lightGrayColor().setStroke()
        path.stroke()
        
        let logoImage = UIImage(named: "logo")
        logoImage?.drawInRect(bounds)
    }
}
