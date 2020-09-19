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
        let groceryDictionary : [String : Any] = [
            "name" : grocery.name ?? "",
            "description" : grocery.description ?? "",
            "amount" : grocery.amount ?? ""
        ]
        
        db.collection("groceries")
            .document(grocery.name ?? "")
            .setData(groceryDictionary){ err in
                if let error = err{
                    print("Failed to add data => \(error.localizedDescription)")
                } else{
                    print("Successfully add data")
                }
        }
    }
    
    func deleteGrocery(grocery: GroceryVO) {
    
    } 
}
