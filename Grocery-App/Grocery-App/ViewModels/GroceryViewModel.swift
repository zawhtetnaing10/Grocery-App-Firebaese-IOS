//
//  GroceryViewModel.swift
//  Grocery-App
//
//  Created by Zaw Htet Naing on 18/09/2020.
//  Copyright © 2020 Zaw Htet Naing. All rights reserved.
//

import Foundation
import Combine

class GroceryViewModel : ObservableObject{
    
    // Models
    let mGroceryModel : GroceryModel = GroceryModelImpl()
    
    // Data
    @Published var groceries : [GroceryVO] = []
    @Published var isPopOverShown : Bool = false
    
    @Published var groceryName : String = ""
    @Published var groceryDescription : String = ""
    @Published var groceryAmount : String = ""
    
    init(){
        mGroceryModel.getAllGroceries(success: { (groceries) in
            self.groceries = groceries
        }) { (error) in
            print(error)
        }
    }
    
    func onTapAddGrocery(){
        
    }
    
    func onTapEditGrocery(groceryName: String , groceryDescription : String, groceryAmount: String){
        self.groceryName = groceryName
        self.groceryDescription = groceryDescription
        self.groceryAmount = groceryAmount
    }
}
