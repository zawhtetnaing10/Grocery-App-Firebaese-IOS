//
//  AuthenticationModelImpl.swift
//  Grocery-App
//
//  Created by Zaw Htet Naing on 10/10/2020.
//  Copyright © 2020 Zaw Htet Naing. All rights reserved.
//

import Foundation

class AuthenticationModelImpl : AuthenticationModel{
    
    let mAuthManager : AuthManager = FirebaseAuthManagerImpl()
    
    func login(email: String, password: String, onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void) {
        mAuthManager.login(email: email, password: password, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func register(email: String, password: String, userName: String, onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void) {
        mAuthManager.register(email: email, password: password, userName: userName, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func getUserName() -> String {
        return mAuthManager.getUserName()
    }
}
