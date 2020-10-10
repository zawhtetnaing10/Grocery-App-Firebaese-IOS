//
//  AuthManager.swift
//  Grocery-App
//
//  Created by Zaw Htet Naing on 09/10/2020.
//  Copyright © 2020 Zaw Htet Naing. All rights reserved.
//

import Foundation

protocol AuthManager{
    func login(email: String, password: String, onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void)
    func register(email: String, password: String, userName: String, onSuccess: @escaping  () -> Void, onFailure: @escaping (String) -> Void)
    func getUserName() -> String
}
