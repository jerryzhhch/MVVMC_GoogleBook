//
//  Storyboarder.swift
//  GoogleBooks
//
//  Created by Jerry Zhou on 8/1/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

protocol Storyboarder {
    static func instantiate() -> Self
}

extension Storyboarder where Self: UIViewController {
    
    static func instantiate() -> Self {
        let name = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        return storyboard.instantiateViewController(withIdentifier: name) as! Self
    }
    
    
} //end extension
