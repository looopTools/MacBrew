//
//  SettingsHandler.swift
//  MacBrew
//
//  Created by Lars Nielsen on 02/10/16.
//  Copyright © 2016 Lars Nielsen. All rights reserved.
//

import Foundation

struct SettingsHandler {
    
    var isCaskOn: Bool = false
    
    var settings = NSUserDefaults.standardUserDefaults()
    
    mutating func loadSettings() {
        if Array(settings.dictionaryRepresentation().keys).contains("isCaskOn") {
            isCaskOn = settings.boolForKey("isCaskOn")
        }
    }
    
    func getIsCaskOn() -> Bool {
        return isCaskOn
    }
    
    func setIsCaksOn(value: Bool) {
        settings.setBool(value, forKey: "isCaskOn")
    }
    
    
    
}