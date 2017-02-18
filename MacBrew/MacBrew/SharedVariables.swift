//
//  SharedVariables.swift
//  MacBrew
//
//  Created by Lars Nielsen on 28/09/16.
//  Copyright © 2016 Lars Nielsen. All rights reserved.
//

import Foundation

// All variables in this file is used application wide 
// And should NEVER be changed 

var installed_packages: [Brew] = []

struct SharedVariables {

    func launchPath() -> String {
        return "/usr/local/bin/brew"
    }
    
    func isBrewInInstalledList(brew:Brew) -> Bool {
        for value in installed_packages {
            if value.name == brew.name {
                return true
            }
        }
        return false
    }


}



