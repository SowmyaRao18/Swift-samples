//
//  StormWindowController.swift
//  StormViewer
//
//  Created by sowmya rao on 11/05/17.
//  Copyright © 2017 Exilant. All rights reserved.
//

import Cocoa

// Storm Controller which handles loading of Storm name and Images

class StormWindowController: NSWindowController,NSTableViewDelegate
{

    // MARK: Properties
    @IBOutlet weak var tableView : NSTableView!
    @IBOutlet weak var arrayController : NSArrayController!
    
    @IBOutlet weak var stormImageView: NSImageView!
    
    dynamic var storms :[Storm] = []
    
    // MARK: -----------------------------------------------------------
    override func windowDidLoad()
    {
        super.windowDidLoad()
        
        // Create the array with Storm model and add  it to Array controller as contents
        let storm1 = Storm(name: "Alberto", image: NSImage(named:"nssl0033")!)
        let storm2 = Storm(name: "Florence", image: NSImage(named:"nssl0034")!)
        let storm3 = Storm(name: "Sandy", image: NSImage(named:"nssl0041")!)
        let storm4 = Storm(name: "Kirk", image: NSImage(named:"nssl0049")!)
        let storm5 = Storm(name: "Gordon", image: NSImage(named:"nssl0051")!)
        storms.append(storm1)
        storms.append(storm2)
        storms.append(storm3)
        storms.append(storm4)
        storms.append(storm5)
        
        // Using the View based table view to populate table
        tableView?.reloadData()
        tableView.selectRowIndexes(NSIndexSet(index: 0) as IndexSet, byExtendingSelection : true )
        
    }
    
    override var windowNibName: String?
    {
                return "StormWindowController"
    }
    // MARK: ----------------------------------------------------------- 
    
    // MARK: tablew view Delegates
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        if let stormTable = notification.object as? NSTableView
        {
             let row = stormTable.selectedRow
            if row != -1
            {
                let storm = arrayController.selectedObjects.first as? Storm
                stormImageView.image = storm?.image
            }
            
        }
    }
}
