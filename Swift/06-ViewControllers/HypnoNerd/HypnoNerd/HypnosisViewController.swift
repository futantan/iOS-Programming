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
}
