//
//  FirebaseRemoteConfigManager.swift
//  Grocery-App
//
//  Created by Zaw Htet Naing on 17/10/2020.
//  Copyright © 2020 Zaw Htet Naing. All rights reserved.
//

import Foundation
import FirebaseCore
import FirebaseRemoteConfig

class FirebaseRemoteConfigManager{
    
    static let shared = FirebaseRemoteConfigManager()
    
    private init(){}
    
    let remoteConfig : RemoteConfig = {
        let config = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        config.configSettings = settings
        return config
    }()
    
    func setUpRemoteConfigWithDefaultValues(){
        let defaultValues = [
            "mainScreenAppBarTitle" : "Grocery-App" as NSObject,
        ]
        remoteConfig.setDefaults(defaultValues)
    }
    
    func fetchRemoteConfigs(){
        remoteConfig.fetch() { (status, error) -> Void in
          if status == .success {
            print("Configs Fetched")
            self.remoteConfig.activate() { (changed, error) in
              print("Configs updated successfully")
            }
          } else {
            print("Configs fetch failed")
          }
        }
    }
    
    func getToolbarName() -> String{
        return remoteConfig.configValue(forKey: "mainScreenAppBarTitle").stringValue ?? ""
    }
}
