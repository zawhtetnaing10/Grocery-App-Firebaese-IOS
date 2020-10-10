//
//  FirebaseAuthManagerImpl.swift
//  Grocery-App
//
//  Created by Zaw Htet Naing on 09/10/2020.
//  Copyright © 2020 Zaw Htet Naing. All rights reserved.
//

import Foundation
import Firebase

class FirebaseAuthManagerImpl : AuthManager{
    
    let mFirebaseAuth = Auth.auth()
    
    func login(email: String, password: String, onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void){
        mFirebaseAuth.signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error{
                onFailure(error.localizedDescription)
            } else {
                onSuccess()
            }
        }
    }
    
    func register(email: String, password: String, userName: String,  onSuccess: @escaping () -> Void,onFailure:  @escaping  (String) -> Void){
        mFirebaseAuth.createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error{
               onFailure(error.localizedDescription)
            } else {
                guard let user = self.mFirebaseAuth.currentUser else { return }
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = userName
                changeRequest.commitChanges { (error) in
                    if let error = error{
                        onFailure(error.localizedDescription)
                    } else {
                        onSuccess()
                    }
                }
            }
        }
    }
    
    func getUserName() -> String{
        return mFirebaseAuth.currentUser?.displayName ?? ""
    }
}
