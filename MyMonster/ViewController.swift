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
    @IBOutlet weak var skull1Img: UIImageView!
    @IBOutlet weak var skull2Img: UIImageView!
    @IBOutlet weak var skull3Img: UIImageView!
    
    let DIM_ALPHA: CGFloat = 0.2
    let OPAQUE: CGFloat = 1.0
    let MAX_PENALTIES = 3
    var timer: NSTimer!
    
    var penalties = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodImg.dropTarget = monsterImg
        heartImg.dropTarget = monsterImg
        
        skull1Img.alpha = DIM_ALPHA
        skull2Img.alpha = DIM_ALPHA
        skull3Img.alpha = DIM_ALPHA
        
        monsterImg.playIdleAnimation()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnCharacter:", name: "onTargetDropped", object: nil)
        
        startTimer()
                
    }
    
    func itemDroppedOnCharacter(notif: NSNotification) {
      
        
    }
    
    
    func startTimer() {
        if timer != nil {
            timer.invalidate()
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "changeGameState", userInfo: nil, repeats: true)
        
        
    }
    
    
    func changeGameState() {
        
        penalties++
        
        if penalties == 1 {
            skull1Img.alpha = OPAQUE
        } else if penalties == 2 {
            skull2Img.alpha = OPAQUE
        } else if penalties >= 3 {
            skull3Img.alpha = OPAQUE
        }
        
        if penalties >= MAX_PENALTIES {
           gameOver()
        }

        
    }
    
    func gameOver() {
         timer.invalidate()
        monsterImg.playDeathAnimation()
    }

    
}

