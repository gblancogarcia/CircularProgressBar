//
//  CircularProgressBar.swift
//  CircularProgressBar
//
//  Created by Gerardo Blanco García on 11/5/16.
//  Copyright © 2016 Gerardo Blanco García. All rights reserved.
//

import UIKit

@IBDesignable
open class CircularProgressBarView: UIView {
    
    open let minProgress: CGFloat = 0.0
    open let maxProgress: CGFloat = 1.0
    
    let backgroundAlpha: CGFloat = 0.25

    @IBInspectable open var topColor: UIColor = Colors.cyan.color {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable open var bottomColor: UIColor = Colors.magenta.color {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable open var radius: CGFloat = 32.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable open var lineWidth: CGFloat = 4.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable open var showPercentage: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable open var fontSize: CGFloat = 16.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable open var progress: CGFloat = 0.0 {
        didSet {
            if minProgress < 0.0 {
                progress = minProgress
            } else if maxProgress > 1.0 {
                progress = maxProgress
            }
            
            setNeedsDisplay()
        }
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    func setUp() {
        self.backgroundColor = .clear
    }
    
    override open func draw(_ rect: CGRect) {
        super.draw(rect)

        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        drawBackgroundArch(rect, context: context)
        drawArch(rect, context: context)
        
        if showPercentage {
            drawPercentage(rect, context: context)
        }
    }
    
    func drawBackgroundArch(_ rect: CGRect, context: CGContext)  {
        context.saveGState()
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        let offset = CGSize(width: 0.0, height: 0.0)
        let blur: CGFloat = 2.0
        let color = UIColor.black.cgColor
        context.setShadow(offset: offset, blur: blur, color: color)
        
        let archPath = createArcPath(rect, progress: maxProgress)
        archPath.lineWidth = CGFloat(lineWidth)
        archPath.lineCapStyle = .round
        archPath.stroke()
        
        context.setBlendMode(.sourceIn)
        
        let topColor = self.topColor.withAlphaComponent(backgroundAlpha)
        let bottomColor = self.bottomColor.withAlphaComponent(backgroundAlpha)

        let colors = [topColor.cgColor, bottomColor.cgColor] as CFArray
        let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors, locations: [0, 1])!
        let start = CGPoint(x: rect.midX, y: 0.0)
        let end = CGPoint(x: rect.midX, y: rect.height)
        
        context.drawLinearGradient(gradient, start: start, end: end, options: CGGradientDrawingOptions())
        
        context.endTransparencyLayer()
        context.restoreGState()
    }
    
    func drawArch(_ rect: CGRect, context: CGContext)  {
        context.saveGState()
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        let offset = CGSize(width: 0.0, height: 0.0)
        let blur: CGFloat = 2.0
        let color = UIColor.black.cgColor
        context.setShadow(offset: offset, blur: blur, color: color)
        
        let archPath = createArcPath(rect, progress: progress)
        archPath.lineWidth = CGFloat(lineWidth)
        archPath.lineCapStyle = .round
        archPath.stroke()
        
        context.setBlendMode(.sourceIn)
        
        let colors = [topColor.cgColor, bottomColor.cgColor] as CFArray
        let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors, locations: [0, 1])!
        let start = CGPoint(x: rect.midX, y: 0.0)
        let end = CGPoint(x: rect.midX, y: rect.height)
        
        context.drawLinearGradient(gradient, start: start, end: end, options: CGGradientDrawingOptions())
        
        context.endTransparencyLayer()
        context.restoreGState()
    }
    
    func drawPercentage(_ rect: CGRect, context: CGContext)  {
        context.saveGState()
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let attributes = [NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle]
        
        let percentage = Int(progress * 100)
        let string = "\(percentage)"

        let size = string.size(attributes: attributes)
        let centeredRect = centered(rect: rect, size: size)
        
        string.draw(in: centeredRect, withAttributes: attributes)
        
        context.setBlendMode(.sourceIn)

        let colors = [topColor.cgColor, bottomColor.cgColor] as CFArray
        let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors, locations: [0, 1])!
        let start = CGPoint(x: rect.midX, y: 0.0)
        let end = CGPoint(x: rect.midX, y: rect.height)
        
        context.drawLinearGradient(gradient, start: start, end: end, options: CGGradientDrawingOptions())
        
        context.endTransparencyLayer()
        context.restoreGState()
    }

    func createArcPath(_ rect: CGRect, progress: CGFloat) -> UIBezierPath {
        let degrees: CGFloat = progress * -360.0 + 90.0
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let startAngle = -90.0 * CGFloat.pi / 180.0
        let endAngle = -degrees * CGFloat.pi / 180.0
        
        let path = UIBezierPath()
        path.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        return path
    }
    
    func createStartCapPath(_ rect: CGRect) -> UIBezierPath {
        let degrees: CGFloat = 90.0
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        let arcCenter = pointFrom(center: center, radius: radius, degrees: degrees)
        let arcRadius: CGFloat = lineWidth / 2
        let startAngle: CGFloat = 0.0
        let endAngle: CGFloat = CGFloat.pi * 2
        
        let path = UIBezierPath()
        path.addArc(withCenter: arcCenter, radius: arcRadius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        return path
    }

    func createEndCapPath(_ rect: CGRect) -> UIBezierPath {
        let degrees: CGFloat = progress * -360.0 + 90.0
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        let arcCenter = pointFrom(center: center, radius: radius, degrees: degrees)
        let arcRadius: CGFloat = lineWidth / 2
        let startAngle: CGFloat = 0.0
        let endAngle: CGFloat = CGFloat.pi * 2
        
        let path = UIBezierPath()
        path.addArc(withCenter: arcCenter, radius: arcRadius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        return path
    }
    
    func pointFrom(center: CGPoint, radius: CGFloat, degrees: CGFloat) -> CGPoint {
        var result: CGPoint = CGPoint.zero
        
        let radians = degreesToRadians(Double(-degrees))

        let y = round(Double(radius) * sin(radians)) + Double(center.y)
        let x = round(Double(radius) * cos(radians)) + Double(center.x)
        
        result.y = CGFloat(y)
        result.x = CGFloat(x)
        
        return result;
    }
    
    func degreesToRadians(_ degrees: Double) -> Double {
        return degrees * .pi / 180
    }
    
    func centered(rect: CGRect, size: CGSize) ->  CGRect {
        let x = rect.origin.x
        let y = rect.origin.y + (rect.size.height - size.height) / 2.0
        let width = rect.size.width
        let height = size.height
        
        return CGRect(x: x, y: y, width: width, height: height)
    }
}
