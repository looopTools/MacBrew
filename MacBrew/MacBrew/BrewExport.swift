//
//  BrewExport.swift
//  MacBrew
//
//  Created by Morten Telling on 03/10/2016.
//  Copyright © 2016 Lars Nielsen. All rights reserved.
//

import Foundation

struct BrewExport {
    
    func export(path: String) throws {
        
        let casks = BrewSearch().brewSearch("cask", "list")
        let brews = BrewSearch().brewSearch("list")
        
        try exportToFile(path, brews: brews, casks: casks)
        
    }
    
    func exportToFile(path: String, brews: [String], casks: [String]) throws {
        var text = "#!/bin/bash \n# Installed Brew Packages \n";
        for item in brews {
            text += "brew install " + item + " \n"
        }
        
        text += "\n# Installed Cask Packages\n"
        
        for item in casks {
            text += "brew cask install " + item + " \n"
        }
        
        try text.writeToFile(path, atomically:true, encoding:NSASCIIStringEncoding)
        
    }
    
}
