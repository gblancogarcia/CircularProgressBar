//
//  CircularLoadingBar.swift
//  CircularLoadingBar
//
//  Created by Gerardo Blanco García on 14/5/16.
//  Copyright © 2016 Gerardo Blanco García. All rights reserved.
//

import UIKit

private let step = CGFloat(15)
private let timeInterval: TimeInterval = 0.05

@IBDesignable
class CircularLoadingBar: UIView {
    
    var started = false
    
    fileprivate var angle: CGFloat = 0.0
    fileprivate var timer = Timer()
    
    override func draw(_ rect: CGRect) {
        StyleKit.drawCircularLoadingBar(angle: angle)
    }
    
    fileprivate func updateUserInterface() {
        setNeedsDisplay()
    }
    
    func start() {
        started = true
        let selector = #selector(incrementAngle)
        
        timer.invalidate()
        timer = .scheduledTimer(timeInterval: timeInterval, target: self, selector: selector, userInfo: nil, repeats: true)
    }
    
    func stop() {
        timer.invalidate()
        updateUserInterface()
        started = false
    }
    
    func incrementAngle() {
        DispatchQueue.main.async {
            self.angle = (self.angle + step).truncatingRemainder(dividingBy: 360)
            self.updateUserInterface()
        }
    }
}
