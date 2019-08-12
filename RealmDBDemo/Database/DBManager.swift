//
//  DB.swift
//  RealmSwift
//
//  Created by Shubham on 12/07/17.
//  Copyright © 2017 Shubham. All rights reserved.
//

import UIKit
import RealmSwift

class DBManager {
    
     
    private var database : Realm
    static let sharedInstance = DBManager()
    
    private init() {
        database = try! Realm()
    }
    
    func getDataFromDB() -> Results<Item> {
        let results: Results<Item> = database.objects(Item.self)
        return results
    }
    
    func addData(object: Item) {

        try! database.write {
            database.add(object, update: true)
            print("Added new object")
        }
    }
    
    func deleteAllDatabase()  {
        try! database.write {
            database.deleteAll()
        }
    }
    
    func deleteFromDb(object: Item) {
        try! database.write {           
            database.delete(object)
        }
    }
    
    func updateToDb(object: Item,id: Int,dataToUpdate: String,imgToUpload: Data){
        let myObject = database.objects(Item.self).filter("ID == \(id)").first
        try! database.write {
            myObject!.textString = dataToUpdate
            myObject?.picture = imgToUpload
        }
        
//        let results: Results<Item> = database.objects(Item.self)
//        return results
    }
    
    deinit {
        print("Items Deallocated")
    }
    
}



