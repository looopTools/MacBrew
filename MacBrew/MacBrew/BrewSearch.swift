//
//  SearchBrew.swift
//  MacBrew
//
//  Created by Lars Nielsen on 28/09/16.
//  Copyright © 2016 Lars Nielsen. All rights reserved.
//

import Foundation

struct BrewSearch
{
    // Return list instead
    func search(_ term: String) -> [String] {
        
        let result = brewSearch("search", term)
        return result
    }
    
    // Return list instead
    // Inspired by: http://stackoverflow.com/q/29548811/936269
    // Inspired by: http://stackoverflow.com/a/29549342/936269
    func brewSearch(_ args: String...) -> [String] {
        
        // Basic setup of NSTask
        let task = Process()
        task.launchPath = LAUNCH_PATH
        task.arguments = args
        
        // Create a pipe and set it as the output for the task
        let pipe = Pipe()
        task.standardOutput = pipe
        
        task.launch()
        task.waitUntilExit()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output: String = NSString(data: data, encoding: String.Encoding.ascii.rawValue)! as String
        // let status = task.terminationStatus // USE FOR ERROR HANDLING
        
        let result = searchResultStringToList(output)
        return result
    }
    
    func searchResultStringToList(_ input: String) -> [String] {
        let temp = input.characters.split{$0 == "\n"}.map(String.init)
        var result = [String]()
        
        for searchItem in temp {
            result.append(clearSearchResultString(searchItem))
        }
        
        return result
    }
    
    func clearSearchResultString(_ input: String) -> String {
        
        var temp = input.characters.split{$0 == "/"}.map(String.init)
        
        let result = temp[temp.count - 1]
        
        return result
    }
}
