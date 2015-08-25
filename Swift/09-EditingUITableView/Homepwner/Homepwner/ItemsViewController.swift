//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by luckytantanfu on 8/17/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    @IBOutlet var headerView: UIView?
    
    @IBAction func addNewItem(sender: AnyObject) {
        
    }
    
    @IBAction func toggleEditingMode(sender: AnyObject) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "UITableViewCell")
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemStore.sharedStore.allItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath) as! UITableViewCell
        
        let items = ItemStore.sharedStore.allItems
        let item = items[indexPath.row]
        cell.textLabel?.text = item.description
        return cell
    }
}

