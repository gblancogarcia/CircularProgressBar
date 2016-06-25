//
//  Colors.swift
//  CircularProgressBar
//
//  Created by Gerardo Blanco García on 25/6/16.
//  Copyright © 2016 Gerardo Blanco García. All rights reserved.
//

import UIKit

enum Colors {
    
    case Cyan, Magenta
    
    var color: UIColor {
        switch self {
        case .Cyan:
            return UIColor(red: 0.0, green: 1.0, blue: 1.0, alpha: 1.0)
            
        case .Magenta:
            return UIColor(red: 1.0, green: 0.0, blue: 1.0, alpha: 1.0)
        }
    }
}
