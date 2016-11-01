import UIKit
import PlaygroundSupport

import CircularProgressBar


let rect = CGRect(x: 0.0, y: 0.0, width: 128.0, height: 128.0)
let offset = CGPoint(x: -1.0, y: -1.0)

let gridView = GridView(frame: rect)
gridView.gridSize = 4
gridView.majorLineEvery = 4
//gridView.offset = offset

let circularProgressBarView = CircularProgressBarView(frame: rect)
circularProgressBarView.showPercentage = true
circularProgressBarView.progress = 0.25
circularProgressBarView.radius = 60
circularProgressBarView.lineWidth = 4
circularProgressBarView.fontSize = 32.0

gridView.addSubview(circularProgressBarView)

