//
//  GroceryViewModel.swift
//  Grocery-App
//
//  Created by Zaw Htet Naing on 18/09/2020.
//  Copyright © 2020 Zaw Htet Naing. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class GroceryViewModel : ObservableObject{
    @Published var groceries : [Int] = [1,2,3,4,5,6,7,8,9,10]
    @Published var isPopOverShown : Bool = false
    
    @Published var groceryName : String = ""
    @Published var groceryDescription : String = ""
    @Published var groceryAmount : String = ""
    
    func onTapAddGrocery(){
        
    }
    
    func onTapEditGrocery(groceryName: String , groceryDescription : String, groceryAmount: String){
        self.groceryName = groceryName
        self.groceryDescription = groceryDescription
        self.groceryAmount = groceryAmount
    }
}
