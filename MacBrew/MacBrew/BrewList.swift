//
//  BrewList.swift
//  MacBrew
//
//  Created by Lars Nielsen on 01/10/16.
//  Copyright © 2016 Lars Nielsen. All rights reserved.
//

import Foundation

struct BrewList {

    func list() -> [String] {
        // Basic setup of NSTask
        let task = NSTask()
        task.launchPath = LAUNCH_PATH
        task.arguments = ["list"]
        
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
    
    func searchResultStringToList(input: String) -> [String] {
        return input.characters.split{$0 == "\n"}.map(String.init)
    }
}
