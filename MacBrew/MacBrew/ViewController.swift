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

    var packages:[Package]?

    override func viewDidLoad() {

        super.viewDidLoad()
        packageList.setDelegate(self)
        packageList.setDataSource(self)

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
        // logic for update
        packageList.endUpdates()
    }

}

extension ViewController : NSTableViewDataSource {
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return packages?.count ?? 0
    }
}

extension ViewController : NSTableViewDelegate {
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {

        var text:String = ""
        var cellIdentifier: String = ""

        // 1
        guard let item = packages?[row] else {
            return nil
        }

        // 2
        if tableColumn == tableView.tableColumns[0] {
            text = item._name
            cellIdentifier = "nameCellId"
        } else if tableColumn == tableView.tableColumns[1] {
            text = item._description
            cellIdentifier = "descriptionCellId"
        } else if tableColumn == tableView.tableColumns[2] {
            if !item._outdated {
                text = "YES"
            } else {
                text = "NO"
            }
            cellIdentifier = "uptoDateCellId"
        }

        // 3
        if let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
            return cell
        }
        return nil
    }
}
