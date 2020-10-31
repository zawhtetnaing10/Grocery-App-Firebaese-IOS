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
            NavigationLink(destination: ContentView(), isActive: $isNavigateToHomeScreen){
                LoginView()
            }
            .onOpenURL { (url) in
                if(url.absoluteString == "https://padc.com.mm"){
                    isNavigateToHomeScreen = true
                }
            }
           
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
