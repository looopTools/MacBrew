//
//  Package.swift
//  MacBrew
//
//  Created by Lars Nielsen on 14/10/16.
//  Copyright © 2016 Lars Nielsen. All rights reserved.
//

import Foundation

class Package {

    var _name: String
    var _description: String
    var _outdated: Bool
    
    init(name: String, description: String, outdated: Bool) {
        _name = name
        _description = description
        _outdated = outdated
    
    }

    // Made with the assumtion that a package is not in the outdated liste
    init(name: String, description: String) {
        _name = name
        _description = description
        _outdated = false
    }
}