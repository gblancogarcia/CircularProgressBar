//
//  CircularLoadingBar.swift
//  CircularLoadingBar
//
//  Created by Gerardo Blanco García on 14/5/16.
//  Copyright © 2016 Gerardo Blanco García. All rights reserved.
//

import UIKit

private let step = CGFloat(15)
private let timeInterval: NSTimeInterval = 0.05

@IBDesignable
class CircularLoadingBar: UIView {
    
    var started = false
    
    private var angle: CGFloat = 0.0
    private var timer = NSTimer()
    
    override func drawRect(rect: CGRect) {
        StyleKit.drawCircularLoadingBar(angle: angle)
    }
    
    private func updateUserInterface() {
        setNeedsDisplay()
    }
    
    func start() {
        started = true
        let selector = #selector(incrementAngle)
        
        timer.invalidate()
        timer = .scheduledTimerWithTimeInterval(timeInterval, target: self, selector: selector, userInfo: nil, repeats: true)
    }
    
    func stop() {
        timer.invalidate()
        updateUserInterface()
        started = false
    }
    
    func incrementAngle() {
        dispatch_async(dispatch_get_main_queue()) {
            self.angle = (self.angle + step) % 360
            self.updateUserInterface()
        }
    }
}
