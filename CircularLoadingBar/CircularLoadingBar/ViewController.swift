//
//  ViewController.swift
//  CircularLoadingBar
//
//  Created by Gerardo Blanco García on 14/5/16.
//  Copyright © 2016 Gerardo Blanco García. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var circularLoadingBar: CircularLoadingBar!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func buttonPressed(sender: UIButton) {
        let started = circularLoadingBar.started
        
        if started {
            circularLoadingBar.stop()
        } else {
            circularLoadingBar.start()
        }
        
        let title = started ? "Start" : "Stop"
        
        button.setTitle(title, forState: .Normal)
    }
}

