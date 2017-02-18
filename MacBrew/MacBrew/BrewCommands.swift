//
//  BrewCommands.swift
//  MacBrew
//
//  Created by Lars Nielsen on 18/02/2017.
//  Copyright © 2017 Lars Nielsen. All rights reserved.
//

import Foundation

class BrewCommands {

 
    func description(brew:Brew) {
        brew.description = description(brew:brew.name)
    }
    
    func description(brew:String) -> String {
        return runCommandWithOutput("desc", brew)[0]
    }
    
    func list() {
        let temp = convertResultToBrews(brewsAsStrings: runCommandWithOutput("list"))
        
        for item in temp {
            item.installed = true
            if !SharedVariables().isBrewInInstalledList(brew: item) {
                installed_packages.append(item)
            }
        }
        
        outdated()
    }
    
    func search(term:String) -> [Brew] {
        
        let temp = runCommandWithOutput("search", term)
        
        
        return []
    }
    
    func outdated() {
        let temp = splitIntoNamesOnly(runCommandWithOutput("outdated"))
        
        for value in temp {
            for item in installed_packages {
                if item.name == value {
                    item.outdated = true
                } else {
                    break
                }
            }
        }
    }

    
    /// From here helper functions only 
    
    func runCommand(_ args: String...) -> Int32 {
        let task = Process()
        let tmp = SharedVariables()
        task.launchPath = tmp.launchPath()
        task.arguments = args
        task.launch()
        task.waitUntilExit()
        return task.terminationStatus
    }
    
    func runCommandWithOutput(_ args: String...) -> [String] {
        
        // Basic setup of NSTask
        let task = Process()
        task.launchPath = SharedVariables().launchPath()
        task.arguments = args
        
        // Create a pipe and set it as the output for the task
        let pipe = Pipe()
        task.standardOutput = pipe
        task.launch()
        task.waitUntilExit()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output: String = NSString(data: data, encoding: String.Encoding.ascii.rawValue)! as String
        // let status = task.terminationStatus // USE FOR ERROR HANDLING
        
        return searchResultStringToList(output)
        
    }

    func searchResultStringToList(_ input: String) -> [String] {
        return input.characters.split{$0 == "\n"}.map(String.init)
    }
    
    func splitIntoNamesOnly(_ input:[String]) -> [String] {
        var result:[String] = []
        
        for value in input {
            result.append(value.characters.split{$0 == " "}.map(String.init)[0])
        }
        return result
    }

    func convertResultToBrews(brewsAsStrings:[String]) -> [Brew] {
        var results:[Brew] = []
        
        for item in brewsAsStrings {
            let temp = Brew(name: item, type: BrewType.standard)
            BrewCommands().description(brew: temp)
            results.append(temp)
        }
        return results
    }
    
}
