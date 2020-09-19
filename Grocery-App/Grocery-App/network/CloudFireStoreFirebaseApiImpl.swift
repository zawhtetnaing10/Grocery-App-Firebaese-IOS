//
//  CloudFireStoreFirebaseApiImpl.swift
//  Grocery-App
//
//  Created by Zaw Htet Naing on 19/09/2020.
//  Copyright © 2020 Zaw Htet Naing. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

class CloudFireStoreFirebaseApiImpl : FirebaseApi{
    
    let db = Firestore.firestore()
    
    func getAllGroceries(success: @escaping ([GroceryVO]) -> Void, failure: @escaping (String) -> Void) {
        db.collection("groceries").addSnapshotListener{ snapshot, error in
            var groceriesList : [GroceryVO] = []
            
            snapshot?.documents.forEach{ singleSnapShot in
                let grocery = GroceryVO()
                grocery.name = singleSnapShot["name"] as? String
                grocery.description = singleSnapShot["description"] as? String
                grocery.amount = singleSnapShot["amount"] as? Int
                groceriesList.append(grocery)
            }
            
            success(groceriesList)
        }
    }
    
    func addGrocery(grocery: GroceryVO) {
        
    }
    
    func deleteGrocery(grocery: GroceryVO) {
    
    } 
}
