//
//  Storm.swift
//  StormViewer
//
//  Created by sowmya rao on 11/05/17.
//  Copyright © 2017 Exilant. All rights reserved.
//

import Cocoa

// Subclass of Nsobject since we are using Bindings(else we will not be able to use KVC/KVO)

// Storm Model which holds the Storm name and Image
class Storm : NSObject
{
    let name : String
    let image : NSImage
    
    // Initializer
    init(name : String, image :NSImage) {
        self.name = name
        self.image = image
        super.init()
    }
    func imageForName () -> NSImage
    {
        return self.image
    }
}
