//
//  CircularProgressBar.swift
//  CircularProgressBar
//
//  Created by Gerardo Blanco García on 11/5/16.
//  Copyright © 2016 Gerardo Blanco García. All rights reserved.
//

import UIKit

@IBDesignable
class CircularProgressBar: UIView {
    
    private var _progress: CGFloat = 0.0
    
    var progress : CGFloat {
        set (value) {
            if value > 1.0 {
                _progress = 1.0
            } else if value < 0.0 {
                _progress = 0
            } else {
                _progress = value
            }
            
            setNeedsDisplay()
        }
        get {
            return _progress
        }
    }

    override func drawRect(rect: CGRect) {
        StyleKit.drawCircularProgressBar(progress: _progress)
    }
}
