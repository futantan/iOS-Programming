//
//  Item.swift
//  RandomItems
//
//  Created by luckytantanfu on 8/4/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

import Foundation

class Item: Printable {
    var itemName: String
    var serialNumber: String
    var valueInDollars: Int
    var dateCreated: NSDate

    class var randomItem: Item {
        let randomAdjectiveList = ["Fluffy", "Rusty", "Shiny"]
        let randomNounList = ["Bear", "Spork", "Mac"]

        let adjectiveIndex = Int(arc4random_uniform(UInt32(randomAdjectiveList.count)))
        let nounIndex = Int(arc4random_uniform(UInt32(randomNounList.count)))
        let randomName = String(format: "%@ %@", randomAdjectiveList[adjectiveIndex], randomNounList[nounIndex])

        let randomValue = Int(arc4random_uniform(100))

        let numArray = Array("0123456789")
        let charArray = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")

        let randomSerialNumber =
                "\(numArray[Int(arc4random_uniform(10))])" +
                "\(charArray[Int(arc4random_uniform(26))])" +
                "\(numArray[Int(arc4random_uniform(10))])" +
                "\(charArray[Int(arc4random_uniform(26))])" +
                "\(numArray[Int(arc4random_uniform(10))]))"

        return Item(itemName: randomName, valueInDollars: randomValue, serialNumber: randomSerialNumber)
    }

    init(itemName: String, valueInDollars: Int, serialNumber: String) {
        self.itemName = itemName
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        dateCreated = NSDate()
    }

    convenience init(itemName name: String) {
        self.init(itemName: name, valueInDollars: 0, serialNumber: "0")
    }

    convenience init() {
        self.init(itemName: "Item")
    }

    var description: String {
        let descriptionString = String(format: "%@ (%@): Worth $%d, recorded on %@",
                self.itemName,
                self.serialNumber,
                self.valueInDollars,
                self.dateCreated)

        return descriptionString
    }


}


