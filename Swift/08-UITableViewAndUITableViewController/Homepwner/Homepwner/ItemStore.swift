//
//  ItemStore.swift
//  Homepwner
//
//  Created by luckytantanfu on 8/18/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

import Foundation

private let sharedInstance = ItemStore()

class ItemStore {
    
    internal private(set) var allItems: [Item]
    
    // 私有化构造器，让其只能通过sharedStore获得实例
    private init() {
        allItems = [Item]()
        for i in 1...50 {
            allItems.append(Item.randomItem)
        }
    }
    
    class var sharedStore: ItemStore {
        return sharedInstance
    }
  
    func createItem() -> Item {
        let item = Item.randomItem
        allItems.append(item)
        return item
    }
    
}