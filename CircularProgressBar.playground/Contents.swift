import UIKit
import PlaygroundSupport
import CircularProgressBar

let x = 0.0
let y = 0.0
let width = 80.0
let height = 80.0

let rect = CGRect(x: x, y: y, width: width, height: height)

let circularProgressBar = CircularProgressBarView(frame: rect)
circularProgressBar.progress = 0.75
