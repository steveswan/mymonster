//
//  ViewController.swift
//  MyMonster
//
//  Created by Stephen Labedz on 3/3/16.
//  Copyright © 2016 Stephen Labedz. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var monsterImg: UIImageView!
    @IBOutlet weak var foodImg: UIImageView!
    @IBOutlet weak var heartImg: UIImageView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var imgArray = [UIImage]()
        
        for var x = 1; x <= 4; x++ {
            let img = UIImage(named: "idle\(x).png")
            imgArray.append(img!)
        }

        
        monsterImg.animationImages = imgArray
        monsterImg.animationDuration = 0.8
        monsterImg.animationRepeatCount = 0
        monsterImg.startAnimating()
        
    }


    
}

