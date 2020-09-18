//
//  FirebaseRealtimeDatabaseApiImpl.swift
//  Grocery-App
//
//  Created by Zaw Htet Naing on 18/09/2020.
//  Copyright © 2020 Zaw Htet Naing. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FirebaseRealtimeDatabaseApiImpl : FirebaseApi{
    
    var ref: DatabaseReference = Database.database().reference()
    
    func getAllGroceries(success: @escaping([GroceryVO]) -> Void, failure: @escaping (String) -> Void){
        ref.child("groceries").observe(DataEventType.value, with: { (snapshot) in
            
            var groceriesList : [GroceryVO] = []
            
            snapshot.children.forEach{ singleSnapShot in
                let grocery = GroceryVO()
                let groceryDictionary = (singleSnapShot as? DataSnapshot)?.value as? [String : AnyObject] ?? [:]
                grocery.name = groceryDictionary["name"] as? String
                grocery.description = groceryDictionary["description"] as? String
                grocery.amount = groceryDictionary["amount"] as? Int
                groceriesList.append(grocery)
            }
            
            success(groceriesList)
        })
    }
}
