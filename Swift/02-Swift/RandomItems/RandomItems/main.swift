//
//  main.swift
//  RandomItems
//
//  Created by luckytantanfu on 8/4/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

import Foundation

var items = [Item]()

for i in 0 ..< 10 {
    let item = Item.randomItem
    items.append(item)
}

for item in items {
    println(item)
}