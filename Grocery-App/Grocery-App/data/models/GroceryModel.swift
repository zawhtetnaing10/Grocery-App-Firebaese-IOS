//
//  GroceryModel.swift
//  Grocery-App
//
//  Created by Zaw Htet Naing on 18/09/2020.
//  Copyright © 2020 Zaw Htet Naing. All rights reserved.
//

import Foundation

protocol GroceryModel {
    func getAllGroceries(success: @escaping([GroceryVO]) -> Void, failure: @escaping (String) -> Void)
    func addGrocery(grocery: GroceryVO)
    func removeGrocery(grocery: GroceryVO)
}
