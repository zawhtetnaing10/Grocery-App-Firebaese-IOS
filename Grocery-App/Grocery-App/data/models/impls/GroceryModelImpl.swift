//
//  GroceryModelImpl.swift
//  Grocery-App
//
//  Created by Zaw Htet Naing on 18/09/2020.
//  Copyright © 2020 Zaw Htet Naing. All rights reserved.
//

import Foundation

class GroceryModelImpl : GroceryModel{
    
    /// Api
    let mFirebaseApi : FirebaseApi = FirebaseRealtimeDatabaseApiImpl()
    
    func getAllGroceries(success: @escaping([GroceryVO]) -> Void, failure: @escaping (String) -> Void){
        mFirebaseApi.getAllGroceries(success: success, failure: failure)
    }
    
    func addGrocery(grocery: GroceryVO){
        mFirebaseApi.addGrocery(grocery: grocery)
    }
}
