//
//  AppDelegate.swift
//  StormViewer
//
//  Created by sowmya rao on 11/05/17.
//  Copyright © 2017 Exilant. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var mainWindowController  = StormWindowController()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create a window controller
        let mainWindowController = StormWindowController()
        // Put the window of the window controller on screen
        mainWindowController.showWindow(self)
        
        // Set the property to point to the window controller
        self.mainWindowController = mainWindowController
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

