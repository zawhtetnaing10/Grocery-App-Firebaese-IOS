//
//  App.swift
//  Grocery-App
//
//  Created by Zaw Htet Naing on 31/10/2020.
//  Copyright © 2020 Zaw Htet Naing. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit
import Firebase

@main
struct GroceryApp : App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @State var isNavigateToHomeScreen : Bool = false
    
    var body: some Scene{
        WindowGroup{
            NavigationView{
                LoginView()
                    .background(
                        NavigationLink(destination: ContentView(), isActive: $isNavigateToHomeScreen) {
                            EmptyView()
                        }
                    )
                    .onOpenURL { (url) in
                        print("URL =========> \(url)")
                        if(url.absoluteString.contains("home")){
                            isNavigateToHomeScreen = true
                        }
                    }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        InstanceID.instanceID().instanceID { (result, error) in
            guard let result = result else { return }
            print("Firebase Token =======> \(result.token)")
        }
        return true
    }
}
