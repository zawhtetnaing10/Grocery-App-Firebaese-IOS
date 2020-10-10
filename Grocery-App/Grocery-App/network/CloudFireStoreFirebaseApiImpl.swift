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
    
    let storage = Storage.storage()
    
    func getAllGroceries(success: @escaping ([GroceryVO]) -> Void, failure: @escaping (String) -> Void) {
        db.collection("groceries").addSnapshotListener{ snapshot, error in
            var groceriesList : [GroceryVO] = []
            
            snapshot?.documents.forEach{ singleSnapShot in
                let grocery = GroceryVO()
                grocery.name = singleSnapShot["name"] as? String
                grocery.description = singleSnapShot["description"] as? String
                grocery.amount = singleSnapShot["amount"] as? Int
                grocery.image = singleSnapShot["image"] as? String
                groceriesList.append(grocery)
            }
            
            success(groceriesList)
        }
    }
    
    func addGrocery(grocery: GroceryVO) {
        let groceryDictionary : [String : Any] = [
            "name" : grocery.name ?? "",
            "description" : grocery.description ?? "",
            "amount" : grocery.amount ?? "",
            "image" : grocery.image ?? ""
        ]
        
        db.collection("groceries")
            .document(grocery.name ?? "")
            .setData(groceryDictionary){ err in
                if let error = err{
                    print("Failed to add data => \(error.localizedDescription)")
                } else{
                    print("Successfully added data")
                }
        }
    }
    
    func deleteGrocery(grocery: GroceryVO) {
        db.collection("groceries")
            .document(grocery.name ?? "")
            .delete(){ err in
             if let error = err{
                    print("Failed to delete data => \(error.localizedDescription)")
                } else{
                    print("Successfully deleted data")
                }
        }
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
