//
//  BrewInteactions.swift
//  MacBrew
//
//  Created by Lars Nielsen on 28/09/16.
//  Copyright © 2016 Lars Nielsen. All rights reserved.
//

import Foundation


struct BrewInstall {

    // pure install no arguments
    func install(packageName: String) {
        brewInstall("install", packageName)
    }
    
    // Installation using arguments
    func install(packageName: String, args: [String]) {
        
        // Need because spalshing is missing
        // Source: http://stackoverflow.com/a/24024724/936269
        let argumentString = constructArgumentString(args)
        brewInstall("install", packageName, argumentString)
        // When splashing is supported
        // brewInstall(COMMAND, "install", packageName, args)
    }
    
    func unistall(packageName: String, args: [String]) {
        let argumentString = constructArgumentString(args)
        brewInstall("uninstall", packageName, argumentString)
    }
    
    // Inspiration / Stolen from: http://stackoverflow.com/a/26973384/936269
    func brewInstall(args: String...) -> Int32 {
        let task = NSTask()
        task.launchPath = SharedVariables().launchPath()
        task.arguments = args
        task.launch()
        task.waitUntilExit()
        return task.terminationStatus
    }
    
    
    // NOTE: This function should be illiminated when splashing is
    // implemented in Swift.
    func constructArgumentString(args: [String]) -> String {
        var result = ""
        for argument in args {
            result = result + argument
        }
        return result
    }
}