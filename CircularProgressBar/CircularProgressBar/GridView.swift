import UIKit

@IBDesignable
open class GridView: UIView {
    
    @IBInspectable open var showGrid: Bool  = true {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable open var gridSize: Int = 8 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable open var majorLineEvery: Int  = 8 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable open var lineColor: UIColor = UIColor.lightGray.withAlphaComponent(0.25) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable open var majorLineColor: UIColor = UIColor.darkGray.withAlphaComponent(0.25){
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable open var offset: CGPoint = CGPoint(x: 0.0, y: 0.0) {
        didSet {
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
        
        if showGrid {
            drawGrid(rect, context: context)
        }
    }
    
    func drawGrid(_ rect: CGRect, context: CGContext) {
        let width = rect.size.width
        let height = rect.size.height
        
        context.setLineWidth(1.0)
        context.setStrokeColor(lineColor.cgColor)
        
        var y: CGFloat = 0.0 + offset.y
        var i = 0
        
        while y < height {
            if i % majorLineEvery != 0 {
                context.move(to: CGPoint(x: 0.0, y: y))
                context.addLine(to: CGPoint(x: width, y: y))
            }
            
            y += CGFloat(gridSize)
            i += 1
        }
        
        var x: CGFloat = 0.0 + offset.y
        var j = 0
        
        while x < width {
            if j % majorLineEvery != 0 {
                context.move(to: CGPoint(x: x, y: 0.0))
                context.addLine(to: CGPoint(x: x, y: height))
            }
            
            x += CGFloat(gridSize)
            j += 1
        }
        
        context.strokePath()
        
        context.setLineWidth(1.0)
        context.setStrokeColor(majorLineColor.cgColor)
        
        y = 0.0 + offset.y
        i = 0
        
        while y < height {
            if i % majorLineEvery == 0 {
                context.move(to: CGPoint(x: 0.0, y: y))
                context.addLine(to: CGPoint(x: width, y: y))
            }
            
            y += CGFloat(gridSize)
            i += 1
        }
        
        x = 0.0 + offset.x
        j = 0
        
        while x < width {
            if j % majorLineEvery == 0 {
                context.move(to: CGPoint(x: x, y: 0.0))
                context.addLine(to: CGPoint(x: x, y: height))
            }
            
            x += CGFloat(gridSize)
            j += 1
        }
        
        context.strokePath()
    }
}
