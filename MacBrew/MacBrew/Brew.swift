//
//  Brew.swift
//  MacBrew
//
//  Created by Lars Nielsen on 18/02/2017.
//  Copyright © 2017 Lars Nielsen. All rights reserved.
//

import Foundation


class Brew
{
    var name:String
    var type:BrewType
    var description:String
    var installed:Bool
    var outdated:Bool
    
    init(name:String, type:BrewType) {
        self.name = name
        self.type = type
        description = ""
        installed = false
        outdated = false
    }
}
