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
    var m_name:String
    var m_type:BrewType
    var m_description:String
    var m_installed:Bool
    var m_outdated:Bool
    
    init(name:String, type:BrewType) {
        m_name = name
        m_type = type
        m_description = ""
        m_installed = false
        m_outdated = false
    }
}
