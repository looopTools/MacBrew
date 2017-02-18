//
//  BrewUpdate.swift
//  MacBrew
//
//  Created by Lars Nielsen on 07/10/16.
//  Copyright © 2016 Lars Nielsen. All rights reserved.
//

import Foundation

struct BrewUpdate {

    func upgrade(packageName: String) {
        brewUpgrade("upgrade", packageName)
    }
    
    func brewUpgrade(args: String...) -> Int32 {
        let task = NSTask()
        task.launchPath = SharedVariables().launchPath()
        task.arguments = args
        task.launch()
        task.waitUntilExit()
        return task.terminationStatus
    }
    
    func listOutdatedPackages() -> [String] {
        // Basic setup of NSTask
        let task = NSTask()
        task.launchPath = SharedVariables().launchPath()
        task.arguments = ["outdated"]
        
        // Create a pipe and set it as the output for the task
        let pipe = NSPipe()
        task.standardOutput = pipe
        task.launch()
        task.waitUntilExit()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output: String = NSString(data: data, encoding: NSASCIIStringEncoding)! as String
        // let status = task.terminationStatus // USE FOR ERROR HANDLING
        
        let result = searchResultStringToList(output)
        return result
    }
    
    func amountOfOutdatedPackages() -> UInt32 {
        return UInt32(listOutdatedPackages().count)
    }
    
    func searchResultStringToList(input: String) -> [String] {
        return input.characters.split{$0 == "\n"}.map(String.init)
    }
}