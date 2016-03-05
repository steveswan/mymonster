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
    
    @IBOutlet weak var monsterImg: MonsterImg!
    @IBOutlet weak var foodImg: DragImg!
    @IBOutlet weak var heartImg: DragImg!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        monsterImg.playIdleAnimation()
                
    }


    
}

