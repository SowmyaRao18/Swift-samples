//
//  MainWindowController.swift
//  RGBWell
//
//  Created by sowmya rao on 27/03/17.
//  Copyright © 2017 sowmya rao. All rights reserved.
//

import Cocoa

class MainWindowController : NSWindowController
{
    @IBOutlet weak var colorWell : NSColorWell!
    
    @IBOutlet weak var customView : NSView!
    
    var r : Double = 0.0
    var g : Double = 0.0
    var b : Double = 0.0
    let a : Double = 1.0
    
    override var windowNibName: String?
        {
            return "MainWindowController"
    }
    
    @IBAction func adjustRed(sender:NSSlider)
    {
         print("R slider's value is \(sender.floatValue)")
        r = sender.doubleValue
        updateColor()
    }
    
    @IBAction func adjustGreen(sender: NSSlider) {
        print("G slider's value is \(sender.floatValue)")
        g = sender.doubleValue
        updateColor()
    }
    
    @IBAction func adjustBlue(sender: NSSlider) {
        print("B slider's value is \(sender.floatValue)")
        b = sender.doubleValue
        updateColor()
    }
    
    func updateColor() {
        let newColor = NSColor(calibratedRed: CGFloat(r),
                               green: CGFloat(g),
                               blue: CGFloat(b),
                               alpha: CGFloat(a))
        colorWell.color = newColor
    }
    
}
