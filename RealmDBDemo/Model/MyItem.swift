//
//  Item.swift
//  RealmSwift
//
//  Created by Riccardo Rizzo on 12/07/17.
//  Copyright © 2017 Riccardo Rizzo. All rights reserved.
//

import UIKit
import RealmSwift

class Item: Object {
    
    @objc dynamic var ID = -1
    @objc dynamic var textString = ""
    @objc dynamic var picture: Data? = nil
    
    override static func primaryKey() -> String? {
        return "ID"
    }
    
}
