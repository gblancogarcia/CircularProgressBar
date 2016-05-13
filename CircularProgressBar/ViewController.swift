//
//  ViewController.swift
//  CircularProgressBar
//
//  Created by Gerardo Blanco García on 11/5/16.
//  Copyright © 2016 Gerardo Blanco García. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let step: CGFloat = 0.05
    let timeInterval = 0.05
    
    @IBOutlet weak var circularProgressBar: CircularProgressBar!
    @IBOutlet weak var button: UIButton!
    
    var progress: CGFloat = 0;
    var timer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func startTimmer() {
        let selector = #selector(updateCircularProgressBar)

        timer.invalidate()
        timer = .scheduledTimerWithTimeInterval(timeInterval, target: self, selector: selector, userInfo: nil, repeats: true)
    }
    
    func updateCircularProgressBar() {
        if (progress <= 1.0) {
            progress += step;
            circularProgressBar.progress = progress
        } else {
            progress = 1.0
            timer.invalidate()
            button.enabled = true
        }
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        button.enabled = false
        
        progress = 0.0
        circularProgressBar.progress = progress

        startTimmer()
    }
}

