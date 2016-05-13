//
//  ViewController.swift
//  CircularProgressBar
//
//  Created by Gerardo Blanco García on 11/5/16.
//  Copyright © 2016 Gerardo Blanco García. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var circularProgressBar: CircularProgressBar!
    
    var progress:CGFloat = 0;
    var timer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        startTimmer()
    }
    
    func startTimmer() {
        let selector = #selector(updateCircularProgressBar)

        timer.invalidate()
        timer = .scheduledTimerWithTimeInterval(0.1, target: self, selector: selector, userInfo: nil, repeats: true)
    }
    
    func updateCircularProgressBar() {
        if (progress <= 1.0) {
            progress += CGFloat(0.05);
            circularProgressBar.progress = progress
        } else {
            progress = 1.0
            timer.invalidate()
        }
    }
}

