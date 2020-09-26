//
//  FirebaseApi.swift
//  Grocery-App
//
//  Created by Zaw Htet Naing on 18/09/2020.
//  Copyright © 2020 Zaw Htet Naing. All rights reserved.
//

import Foundation

protocol FirebaseApi {
    func getAllGroceries(success: @escaping([GroceryVO]) -> Void, failure: @escaping (String) -> Void)
    func addGrocery(grocery : GroceryVO)
    func deleteGrocery(grocery : GroceryVO)
    func uploadImage(imageData: Data, grocery: GroceryVO)
}
