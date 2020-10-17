//
//  LoginViewModel.swift
//  Grocery-App
//
//  Created by Zaw Htet Naing on 10/10/2020.
//  Copyright © 2020 Zaw Htet Naing. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    @Published var mEmail : String = "";
    @Published var mPassword : String = "";
    
    @Published var isError : Bool = false;
    @Published var errorMessage: String = "";
    
    @Published var isNavigateToRegisterScreen : Bool = false;
    @Published var isNavigateToHomeScreen : Bool = false;
    
    init(){
        mGroceryModel.setUpRemoteConfigWithDefaultValues()
        mGroceryModel.fetchRemoteConfigs()
    }
    
    let mGroceryModel : GroceryModel = GroceryModelImpl()
    let mAuthenticationModel : AuthenticationModel = AuthenticationModelImpl()
    
    func onTapLogin(){
        mAuthenticationModel.login(email: mEmail, password: mPassword, onSuccess: {
            self.isError = false
            self.isNavigateToHomeScreen = true
        }, onFailure: { error in
            DispatchQueue.main.async {
                self.errorMessage = error
                self.isError = true
            }
        })
    }
}
