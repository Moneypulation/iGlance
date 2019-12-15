//
//  ViewController.swift
//  iGlance
//
//  Created by Dominik on 15.12.19.
//  Copyright © 2019 D0miH. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var sidebar: NSTableView!
    let sidebarItems: [String] = ["Dashboard", "CPU", "Memory", "Network"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // add the current ViewController as the delegate and data source of the sidebar
        sidebar.delegate = self
        sidebar.dataSource = self
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func onSidebarItemClick() {
        
    }
}

extension ViewController: NSTableViewDataSource {
    /**
     * Returns the number of rows/items in the sidebar.
     */
    func numberOfRows(in tableView: NSTableView) -> Int {
        print(sidebarItems.count)
        return sidebarItems.count
    }
}

extension ViewController: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let selectedSidebarItem = sidebarItems[row]
        
        // create the cell view
        if let cellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "SidebarItemID"), owner: nil) as? NSTableCellView {
            // set the label and the image
            cellView.textField?.stringValue = selectedSidebarItem
            
            cellView.imageView?.image = NSImage(named: NSImage.actionTemplateName)
            
            // return the created cell view
            return cellView
        } else {
            return nil
        }
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        print(sidebarItems[sidebar.selectedRow])
    }
}

