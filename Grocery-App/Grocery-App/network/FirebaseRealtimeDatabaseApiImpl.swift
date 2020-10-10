//
//  FirebaseRealtimeDatabaseApiImpl.swift
//  Grocery-App
//
//  Created by Zaw Htet Naing on 18/09/2020.
//  Copyright © 2020 Zaw Htet Naing. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

class FirebaseRealtimeDatabaseApiImpl : FirebaseApi{
    
    var ref: DatabaseReference = Database.database().reference()
    
    let storage = Storage.storage()
    
    func getAllGroceries(success: @escaping([GroceryVO]) -> Void, failure: @escaping (String) -> Void){
        ref.child("groceries").observe(DataEventType.value, with: { (snapshot) in
            
            var groceriesList : [GroceryVO] = []
            
            snapshot.children.forEach{ singleSnapShot in
                let grocery = GroceryVO()
                let groceryDictionary = (singleSnapShot as? DataSnapshot)?.value as? [String : AnyObject] ?? [:]
                grocery.name = groceryDictionary["name"] as? String
                grocery.description = groceryDictionary["description"] as? String
                grocery.amount = groceryDictionary["amount"] as? Int
                grocery.image = groceryDictionary["image"] as? String
                groceriesList.append(grocery)
            }
            
            success(groceriesList)
        })
    }
    
    func addGrocery(grocery : GroceryVO){
        ref.child("groceries").child(grocery.name ?? "").setValue([
            "name" : grocery.name ?? "",
            "description" : grocery.description ?? "",
            "amount" : grocery.amount ?? "",
            "image" : grocery.image ?? "",
        ])
    }
    
    func deleteGrocery(grocery : GroceryVO){
        ref.child("groceries").child(grocery.name ?? "").removeValue()
    }
    
    func uploadImage(imageData: Data, grocery: GroceryVO) {

        let storageRef = storage.reference()
        
        let groceryImageRef = storageRef.child("images/\(UUID().uuidString).jpg")

        groceryImageRef.putData(imageData, metadata: nil) { (metadata, error) in
            groceryImageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    return
                }
                grocery.image = downloadURL.absoluteString
                self.addGrocery(grocery: grocery)
            }
        }
    }
    
    
}
