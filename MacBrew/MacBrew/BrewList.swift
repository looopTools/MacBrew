//
//  BrewList.swift
//  MacBrew
//
//  Created by Lars Nielsen on 01/10/16.
//  Copyright © 2016 Lars Nielsen. All rights reserved.
//

import Foundation

struct BrewList {
    
    func list(){
        // Basic setup of NSTask
        let task = Process()
        task.launchPath = SharedVariables().launchPath()
        task.arguments = ["list"]
        
        // Create a pipe and set it as the output for the task
        let pipe = Pipe()
        task.standardOutput = pipe
        task.launch()
        task.waitUntilExit()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output: String = NSString(data: data, encoding: String.Encoding.ascii.rawValue)! as String
        // let status = task.terminationStatus // USE FOR ERROR HANDLING
        
        let result = searchResultStringToList(output)
        
        for item in result {
            let temp = Brew(name: item, type: BrewType.standard)
            temp.installed = true
            BrewCommands().description(brew: temp)
            if !SharedVariables().isBrewInInstalledList(brew: temp) {
                installed_packages.append(temp)
            }
        }
    }
    
    func searchResultStringToList(_ input: String) -> [String] {
        return input.characters.split{$0 == "\n"}.map(String.init)
    }
}
