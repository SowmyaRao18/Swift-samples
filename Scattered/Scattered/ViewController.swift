//
//  ViewController.swift
//  Scattered
//
//  Created by sowmya rao on 15/05/17.
//  Copyright © 2017 Exilant. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    var textLayer: CATextLayer!
    
    var text: String?{
    didSet {
    let font = NSFont.systemFont(ofSize: textLayer.fontSize)
    let attributes = [NSFontAttributeName : font]
    var size = text?.size(withAttributes: attributes) ?? CGSize.zero
    // Ensure that the size is in whole numbers:
    size.width = ceil(size.width)
    size.height = ceil(size.height)
    textLayer.bounds = CGRect(origin: CGPoint.zero, size: size)
    textLayer.superlayer?.bounds
    = CGRect(x: 0, y: 0, width: size.width + 16, height: size.height + 20)
    textLayer.string = text
    }
    }
    
    let processingQueue: OperationQueue = {
        let result = OperationQueue()
        result.maxConcurrentOperationCount = 4
        return result
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set view to be layer-hosting:
        view.layer = CALayer()
        view.wantsLayer = true
        
        let textContainer = CALayer()
        textContainer.anchorPoint = CGPoint.zero
        textContainer.position = CGPoint(x:10, y:10)
        textContainer.zPosition = 100
        textContainer.backgroundColor = NSColor.black.cgColor
        textContainer.borderColor = NSColor.white.cgColor
        textContainer.borderWidth = 2
        textContainer.cornerRadius = 15
        textContainer.shadowOpacity = 0.5
        view.layer!.addSublayer(textContainer)
        
        let textLayer = CATextLayer()
        textLayer.anchorPoint = CGPoint.zero
        textLayer.position = CGPoint(x:10, y:6)
        textLayer.zPosition = 100
        textLayer.fontSize = 24
        textLayer.foregroundColor = NSColor.white.cgColor
        self.textLayer = textLayer
        
        textContainer.addSublayer(textLayer)
        
        // Rely on text's didSet to update textLayer's bounds:
        text = "Loading..."
        
        let url = NSURL(fileURLWithPath: "/Library/Desktop Pictures")
        addImagesFromFolderURL(folderURL: url)
        
    }

    func thumbImageFromImage(image: NSImage) -> NSImage
    {
        let targetHeight: CGFloat = 50.0
        let imageSize = image.size
        let smallerSize
            = NSSize(width: targetHeight * imageSize.width / imageSize.height,
                     height: targetHeight)
        
        let smallerImage = NSImage(size: smallerSize,
                                   flipped: false) { (rect) -> Bool in
                                    image.draw(in: rect)
                                    return true
        }
        
        return smallerImage
    }

    func presentImage(image: NSImage) {
        let superlayerBounds = view.layer!.bounds
        
        let center = CGPoint(x: superlayerBounds.midX, y: superlayerBounds.midY)
        
        let imageBounds = CGRect(origin: CGPoint.zero, size: image.size)
        
        let randomPoint =
            CGPoint(x: CGFloat(arc4random_uniform(UInt32(superlayerBounds.maxX))),
                    y: CGFloat(arc4random_uniform(UInt32(superlayerBounds.maxY))))
        
        let timingFunction
            = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        let positionAnimation = CABasicAnimation()
        positionAnimation.fromValue = NSValue(point: center)
        positionAnimation.duration = 1.5
        positionAnimation.timingFunction = timingFunction
        
        let boundsAnimation = CABasicAnimation()
        boundsAnimation.fromValue = NSValue(rect: CGRect.zero)
        boundsAnimation.duration = 1.5
        boundsAnimation.timingFunction = timingFunction
        
        let layer = CALayer()
        layer.contents = image
        layer.actions =
            ["position" : positionAnimation,
             "bounds"   : boundsAnimation]
        
        CATransaction.begin()
        view.layer!.addSublayer(layer)
        layer.position = randomPoint
        layer.bounds = imageBounds
        CATransaction.commit()
    }
    
    func addImagesFromFolderURL(folderURL: NSURL) {
        
        processingQueue.addOperation() {
            let t0 = NSDate.timeIntervalSinceReferenceDate
        
        let fileManager = FileManager()
        let directoryEnumerator = fileManager.enumerator(at:folderURL as URL,
                                                              includingPropertiesForKeys: nil,
                                                              options: .skipsSubdirectoryDescendants,
                                                              errorHandler: nil)!
        
        
        while let url = directoryEnumerator.nextObject() as? NSURL {
            // Skip directories:
            
            var isDirectoryValue: AnyObject?
            try? url.getResourceValue(&isDirectoryValue,
                                 forKey: URLResourceKey.isDirectoryKey)
            
            if let isDirectory = isDirectoryValue as? NSNumber, isDirectory.boolValue == false {
                self.processingQueue.addOperation() {
                let image = NSImage(contentsOf: url as URL)
                if let image = image {
                    
                    let thumbImage = self.thumbImageFromImage(image:image)
                    // Present the images on UI main queue
                    OperationQueue.main.addOperation() {
                    self.presentImage(image:thumbImage)
                    let t1 = NSDate.timeIntervalSinceReferenceDate
                    let interval = t1 - t0
                    self.text = String(format: "%0.1fs", interval)
                    }
                    }
                }
            }
            }
        }
        
    }
    
    
     override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

