//
//  GroceryViewModel.swift
//  Grocery-App
//
//  Created by Zaw Htet Naing on 18/09/2020.
//  Copyright © 2020 Zaw Htet Naing. All rights reserved.
//

import Foundation
import Combine
import UIKit
import Firebase

class GroceryViewModel : ObservableObject{
    
    // Models
    let mGroceryModel : GroceryModel = GroceryModelImpl()
    
    // Remote Config
    @Published var appBarName : String = ""
    
    // Data
    @Published var groceries : [GroceryVO] = []
    @Published var isPopOverShown : Bool = false
    
    @Published var groceryName : String = ""
    @Published var groceryDescription : String = ""
    @Published var groceryAmount : String = ""
    
    // Image Picker
    @Published var isShowImagePicker : Bool = false
    @Published var chosenImage : UIImage = UIImage()
    
    // Chosen Grocery
    var chosenGrocery : GroceryVO? = nil
    
    init(){
        
        Analytics.logEvent(SCREEN_HOME, parameters: nil)
        
        mGroceryModel.getAllGroceries(success: { [weak self] (groceries) in
            self?.groceries = groceries
        }) { (error) in
            print(error)
        }
        
        appBarName = mGroceryModel.getAppNameFromRemoteConfig()
    }
    
    func onTapAddGrocery(){
        let grocery = GroceryVO()
        grocery.name = groceryName
        grocery.description = groceryDescription
        grocery.amount = Int(groceryAmount) ?? 0
        mGroceryModel.addGrocery(grocery: grocery)
    }
    
    func onDeleteGrocery(grocery : GroceryVO){
        mGroceryModel.removeGrocery(grocery: grocery)
    }
    
    func onTapEditGrocery(groceryName: String , groceryDescription : String, groceryAmount: String){
        self.groceryName = groceryName
        self.groceryDescription = groceryDescription
        self.groceryAmount = groceryAmount
    }
    
    func onGroceryItemChosen(grocery : GroceryVO){
        self.chosenGrocery = grocery
    }
    
    func onImageChosen(image : UIImage){
        guard let chosenGrocery = self.chosenGrocery else { return }
        mGroceryModel.uploadGroceryImage(image: image.jpegData(compressionQuality: 1.0) ?? Data(), grocery: chosenGrocery)
    }
}
