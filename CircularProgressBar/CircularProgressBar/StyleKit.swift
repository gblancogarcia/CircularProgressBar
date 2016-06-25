//
//  StyleKit.swift
//  CircularProgressBar
//
//  Created by Gerardo Blanco García on 25/6/16.
//  Copyright (c) 2016 . All rights reserved.
//

import UIKit

public class StyleKit : NSObject {

    //// Cache

    private struct Cache {
        static let backgroundColor: UIColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1.000)
    }

    //// Colors

    public class var backgroundColor: UIColor { return Cache.backgroundColor }

    //// Drawing Methods

    public class func drawCircularProgressBar(topColor topColor: UIColor = UIColor(red: 0.000, green: 1.000, blue: 1.000, alpha: 1.000), bottomColor: UIColor = UIColor(red: 1.000, green: 0.000, blue: 1.000, alpha: 1.000), progress: CGFloat = 0) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()


        //// Gradient Declarations
        let progressBarGradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [topColor.CGColor, bottomColor.CGColor], [0, 1])!

        //// Variable Declarations
        let angle: CGFloat = progress * 360 * -1 + 90

        //// Background Ring Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, 32, 32)

        let backgroundRingPath = UIBezierPath()
        backgroundRingPath.moveToPoint(CGPointMake(0, -24))
        backgroundRingPath.addCurveToPoint(CGPointMake(-12.38, -20.57), controlPoint1: CGPointMake(-4.53, -24), controlPoint2: CGPointMake(-8.76, -22.75))
        backgroundRingPath.addCurveToPoint(CGPointMake(-24, 0), controlPoint1: CGPointMake(-19.34, -16.37), controlPoint2: CGPointMake(-24, -8.73))
        backgroundRingPath.addCurveToPoint(CGPointMake(-0, 24), controlPoint1: CGPointMake(-24, 13.25), controlPoint2: CGPointMake(-13.25, 24))
        backgroundRingPath.addCurveToPoint(CGPointMake(24, 0), controlPoint1: CGPointMake(13.25, 24), controlPoint2: CGPointMake(24, 13.25))
        backgroundRingPath.addCurveToPoint(CGPointMake(0, -24), controlPoint1: CGPointMake(24, -13.25), controlPoint2: CGPointMake(13.25, -24))
        backgroundRingPath.closePath()
        backgroundRingPath.moveToPoint(CGPointMake(32, 0))
        backgroundRingPath.addCurveToPoint(CGPointMake(-0, 32), controlPoint1: CGPointMake(32, 17.67), controlPoint2: CGPointMake(17.67, 32))
        backgroundRingPath.addCurveToPoint(CGPointMake(-32, 0), controlPoint1: CGPointMake(-17.67, 32), controlPoint2: CGPointMake(-32, 17.67))
        backgroundRingPath.addCurveToPoint(CGPointMake(-19.33, -25.5), controlPoint1: CGPointMake(-32, -10.41), controlPoint2: CGPointMake(-27.03, -19.66))
        backgroundRingPath.addCurveToPoint(CGPointMake(0, -32), controlPoint1: CGPointMake(-13.96, -29.58), controlPoint2: CGPointMake(-7.26, -32))
        backgroundRingPath.addCurveToPoint(CGPointMake(32, 0), controlPoint1: CGPointMake(17.67, -32), controlPoint2: CGPointMake(32, -17.67))
        backgroundRingPath.closePath()
        StyleKit.backgroundColor.setFill()
        backgroundRingPath.fill()

        CGContextRestoreGState(context)


        //// Progress Bar
        CGContextSaveGState(context)
        CGContextBeginTransparencyLayer(context, nil)

        //// Clip Mask
        let maskRect = CGRectMake(0, 0, 64, 64)
        let maskPath = UIBezierPath()
        maskPath.addArcWithCenter(CGPointMake(maskRect.midX, maskRect.midY), radius: maskRect.width / 2, startAngle: -90 * CGFloat(M_PI)/180, endAngle: -angle * CGFloat(M_PI)/180, clockwise: true)
        maskPath.addLineToPoint(CGPointMake(maskRect.midX, maskRect.midY))
        maskPath.closePath()

        maskPath.addClip()


        //// Inner Ring Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, 32, 32)

        let innerRingPath = UIBezierPath()
        innerRingPath.moveToPoint(CGPointMake(0, -24))
        innerRingPath.addCurveToPoint(CGPointMake(-12.38, -20.57), controlPoint1: CGPointMake(-4.53, -24), controlPoint2: CGPointMake(-8.76, -22.75))
        innerRingPath.addCurveToPoint(CGPointMake(-24, 0), controlPoint1: CGPointMake(-19.34, -16.37), controlPoint2: CGPointMake(-24, -8.73))
        innerRingPath.addCurveToPoint(CGPointMake(-0, 24), controlPoint1: CGPointMake(-24, 13.25), controlPoint2: CGPointMake(-13.25, 24))
        innerRingPath.addCurveToPoint(CGPointMake(24, 0), controlPoint1: CGPointMake(13.25, 24), controlPoint2: CGPointMake(24, 13.25))
        innerRingPath.addCurveToPoint(CGPointMake(0, -24), controlPoint1: CGPointMake(24, -13.25), controlPoint2: CGPointMake(13.25, -24))
        innerRingPath.closePath()
        innerRingPath.moveToPoint(CGPointMake(32, 0))
        innerRingPath.addCurveToPoint(CGPointMake(-0, 32), controlPoint1: CGPointMake(32, 17.67), controlPoint2: CGPointMake(17.67, 32))
        innerRingPath.addCurveToPoint(CGPointMake(-32, 0), controlPoint1: CGPointMake(-17.67, 32), controlPoint2: CGPointMake(-32, 17.67))
        innerRingPath.addCurveToPoint(CGPointMake(-19.33, -25.5), controlPoint1: CGPointMake(-32, -10.41), controlPoint2: CGPointMake(-27.03, -19.66))
        innerRingPath.addCurveToPoint(CGPointMake(0, -32), controlPoint1: CGPointMake(-13.96, -29.58), controlPoint2: CGPointMake(-7.26, -32))
        innerRingPath.addCurveToPoint(CGPointMake(32, 0), controlPoint1: CGPointMake(17.67, -32), controlPoint2: CGPointMake(32, -17.67))
        innerRingPath.closePath()
        CGContextSaveGState(context)
        innerRingPath.addClip()
        CGContextDrawLinearGradient(context, progressBarGradient, CGPointMake(-0, -32), CGPointMake(0, 32), CGGradientDrawingOptions())
        CGContextRestoreGState(context)

        CGContextRestoreGState(context)


        CGContextEndTransparencyLayer(context)
        CGContextRestoreGState(context)
    }
}
