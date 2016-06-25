//
//  ViewController.swift
//  CircularProgressBarDemo
//
//  Created by Gerardo Blanco García on 8/6/16.
//  Copyright © 2016 Gerardo Blanco García. All rights reserved.
//

import UIKit
import CircularProgressBar

private let minProgress = CGFloat(0.0)
private let maxProgress = CGFloat(1.0)
private let step = CGFloat(0.05)
private let timeInterval: NSTimeInterval = 0.05

private let start = "Start"
private let stop = "Stop"

class ViewController: UIViewController {
    
    @IBOutlet weak var circularProgressBar: CircularProgressBar!
    @IBOutlet weak var button: UIButton!
    
    var started = false
    var progress: CGFloat = minProgress;
    var timer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setUp() {
        circularProgressBar.topColor = UIColor.cyanColor()
        circularProgressBar.bottomColor = UIColor.magentaColor()
    }
    
    func updateUserInterface() {
        updateProgress()
        updateCircularProgressBar()
        updateButton()
    }
    
    func updateProgress() {
        if progress < maxProgress {
            progress += step;
        } else {
            progress = maxProgress
            stop()
        }
    }
    
    func updateCircularProgressBar() {
        circularProgressBar.progress = progress
    }
    
    func updateButton() {
        button.enabled = !started
    }
    
    func start() {
        started = true
        let selector = #selector(updateUserInterface)
        timer = .scheduledTimerWithTimeInterval(timeInterval, target: self, selector: selector, userInfo: nil, repeats: true)
    }
    
    func stop() {
        timer.invalidate()
        started = false
    }
    
    @IBAction func buttonPressed(sender: UIButton) {
        if started {
            stop()
        }
        
        progress = minProgress
        updateCircularProgressBar()
        
        start()
    }
}

