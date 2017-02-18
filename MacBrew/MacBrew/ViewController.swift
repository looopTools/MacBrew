//
//  ViewController.swift
//  MacBrew
//
//  Created by Lars Nielsen on 28/09/16.
//  Copyright © 2016 Lars Nielsen. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var packageList: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //override var representedObject: AnyObject? {
      //  didSet {
        // Update the view, if already loaded.
       // }
    //}

    @IBAction func searchForPackage(_ sender: NSSearchField) {
        let searchTerm = sender.stringValue;
        let searchResult = BrewSearch().search(searchTerm)
        for item in searchResult {
            print(item)
        }
        
        packageList.beginUpdates()
        // log for update
        packageList.endUpdates()
    }

}

