//
//  ViewController.swift
//  MacBrew
//
//  Created by Lars Nielsen on 28/09/16.
//  Copyright © 2016 Lars Nielsen. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {

    @IBOutlet weak var packageList: NSTableView!

    @IBOutlet weak var updateField: NSTextField!

    var packages:[Brew] = []
    var packageNames:[String] = [] // Bruges til testing (Brug 'packages' når de er hentet. Lige nu får jeg kun navn fra BrewSearch().search )

    override func viewDidLoad() {

        super.viewDidLoad()
        
        packageList.delegate = self
        packageList.dataSource = self
        
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        load_installed_packages()
    }
    
    

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func searchForPackage(_ sender: NSSearchField) {

        let searchTerm = sender.stringValue;
        NSLog(searchTerm)
        //let searchResult = BrewSearch().search(searchTerm) // Burde man ikke få en liste med Packages, i stedet for en liste med strings?
        
        //packageNames = searchResult

    }
        
    func load_installed_packages() {
        BrewCommands().list()
        self.packages = installed_packages
    
        for x in self.packages {
            NSLog(x.name)
        }
        self.packageList.reloadData()
    }
    
    func init_table_view() {
        BrewList().list()
        packages = installed_packages
        packageList.reloadData()
        
    }
    
    

    
    // MARK: NSTableViewDataSource
    func numberOfRows(in tableView: NSTableView) -> Int {
        return packages.count
    }
    
    // MARK: NSTableViewDelegate
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var text:String = ""
        var cellIdentifier: String = ""
        
    
        // Erstat med Package-objekt fra 'packages'
        let item = packages[row]
        
        
        if tableColumn == tableView.tableColumns[0] {
            text = item.name
            cellIdentifier = "nameCellId"
        } else if tableColumn == tableView.tableColumns[1] {
            text = item.description
            cellIdentifier = "descriptionCellId"
        } else if tableColumn == tableView.tableColumns[2] {
            if item.outdated {
                text = "No"
            } else {
                text = "Yes"
            }
            
            //text = "Probably not.." // Placeholder
            cellIdentifier = "uptoDateCellId"
        }
        
        if let cell = tableView.make(withIdentifier: cellIdentifier, owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
            return cell
        }
        return nil
    }
}

