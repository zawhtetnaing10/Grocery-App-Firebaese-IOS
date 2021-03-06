//
//  GroceryModel.swift
//  Grocery-App
//
//  Created by Zaw Htet Naing on 18/09/2020.
//  Copyright © 2020 Zaw Htet Naing. All rights reserved.
//

import Foundation
import UIKit

protocol GroceryModel {
    func getAllGroceries(success: @escaping([GroceryVO]) -> Void, failure: @escaping (String) -> Void)
    func addGrocery(grocery: GroceryVO)
    func removeGrocery(grocery: GroceryVO)
    func uploadGroceryImage(image: Data, grocery: GroceryVO)
    func setUpRemoteConfigWithDefaultValues()
    func fetchRemoteConfigs()
    func getAppNameFromRemoteConfig() -> String
}
