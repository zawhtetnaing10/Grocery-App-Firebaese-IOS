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
    //let mFirebaseApi : FirebaseApi = FirebaseRealtimeDatabaseApiImpl()
    let mFirebaseApi : FirebaseApi = CloudFireStoreFirebaseApiImpl()
    
    let mFirebaseRemoteConfig : FirebaseRemoteConfigManager = FirebaseRemoteConfigManager.shared
    
    func getAllGroceries(success: @escaping([GroceryVO]) -> Void, failure: @escaping (String) -> Void){
        mFirebaseApi.getAllGroceries(success: success, failure: failure)
    }
    
    func addGrocery(grocery: GroceryVO){
        mFirebaseApi.addGrocery(grocery: grocery)
    }
    
    func removeGrocery(grocery: GroceryVO){
        mFirebaseApi.deleteGrocery(grocery: grocery)
    }
    
    func uploadGroceryImage(image: Data, grocery: GroceryVO) {
        mFirebaseApi.uploadImage(imageData: image, grocery: grocery)
    }
    
    func setUpRemoteConfigWithDefaultValues(){
        mFirebaseRemoteConfig.setUpRemoteConfigWithDefaultValues()
    }
    
    func fetchRemoteConfigs(){
        mFirebaseRemoteConfig.fetchRemoteConfigs()
    }
    
    func getAppNameFromRemoteConfig() -> String {
        mFirebaseRemoteConfig.getToolbarName()
    }
}
