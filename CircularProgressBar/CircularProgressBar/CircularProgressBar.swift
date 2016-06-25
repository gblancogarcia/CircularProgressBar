//
//  CircularProgressBar.swift
//  CircularProgressBar
//
//  Created by Gerardo Blanco García on 11/5/16.
//  Copyright © 2016 Gerardo Blanco García. All rights reserved.
//

import UIKit


@IBDesignable
public class CircularProgressBar: UIView {
    
    public let minProgress: CGFloat = 0.0
    public let maxProgress: CGFloat = 1.0
    
    public var topColor: UIColor = Colors.Cyan.color {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public var bottomColor: UIColor = Colors.Magenta.color {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public var progress: CGFloat = 0.0 {
        didSet {
            if minProgress < 0.0 {
                progress = minProgress
            } else if maxProgress > 1.0 {
                progress = maxProgress
            }
            
            setNeedsDisplay()
        }
    }
    
    override public func drawRect(rect: CGRect) {
        StyleKit.drawCircularProgressBar(topColor: topColor, bottomColor: bottomColor, progress: progress)
    }
}
