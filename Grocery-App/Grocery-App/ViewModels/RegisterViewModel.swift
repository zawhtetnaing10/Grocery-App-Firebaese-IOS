//
//  RegisterViewModel.swift
//  Grocery-App
//
//  Created by Zaw Htet Naing on 10/10/2020.
//  Copyright © 2020 Zaw Htet Naing. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class RegisterViewModel: ObservableObject {
    @Published var mEmail : String = "";
    @Published var mPassword : String = ""
    @Published var mUserName : String = "";
    
    @Published var isError : Bool = false;
    @Published var errorMessage: String = "";
    
    let mAuthenticationModel : AuthenticationModel = AuthenticationModelImpl()
    
    func onTapRegister(onSuccess : @escaping () -> Void){
        mAuthenticationModel.register(email: mEmail, password: mPassword, userName: mUserName, onSuccess: onSuccess, onFailure:{ error in
            DispatchQueue.main.async {
                self.errorMessage = error
                self.isError = true
            }
        })
    }
}
