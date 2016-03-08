//
//  ViewController.swift
//  MyMonster
//
//  Created by Stephen Labedz on 3/3/16.
//  Copyright © 2016 Stephen Labedz. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var monsterImg: MonsterImg!
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var foodImg: DragImg!
    @IBOutlet weak var heartImg: DragImg!
    @IBOutlet weak var skull1Img: UIImageView!
    @IBOutlet weak var skull2Img: UIImageView!
    @IBOutlet weak var skull3Img: UIImageView!
    
    @IBOutlet weak var character1: UIButton!
    
    @IBOutlet weak var character2: UIButton!
    
    let DIM_ALPHA: CGFloat = 0.2
    let OPAQUE: CGFloat = 1.0
    let MAX_PENALTIES = 3
    
    var penalties = 0
    var timer: NSTimer!
    var monsterHappy = false
    var gamePlayed = false
    var currentItem: UInt32 = 0
    
    var musicPlayer: AVAudioPlayer!
    var sfxBite: AVAudioPlayer!
    var sfxHeart: AVAudioPlayer!
    var sfxDeath: AVAudioPlayer!
    var sfxSkull: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodImg.dropTarget = monsterImg
        heartImg.dropTarget = monsterImg
        
        
        
        restartGame()
        
    }
    
    func restartGame() {
        
        if !gamePlayed {
            print("this is the first time the game was played")
        } else {
            print("you've already played")
        }
        
        penalties = 0
        skull1Img.alpha = DIM_ALPHA
        skull2Img.alpha = DIM_ALPHA
        skull3Img.alpha = DIM_ALPHA
        
        gamePlayed = true
        selectCharacter()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnCharacter:", name: "onTargetDropped", object: nil)
        
        do {
            try musicPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")!))
            
            try sfxBite = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bite", ofType: "wav")!))
            
            try sfxHeart = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("heart", ofType: "wav")!))
            
            try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("death", ofType: "wav")!))
            
            try sfxSkull = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skull", ofType: "wav")!))
            
            musicPlayer.prepareToPlay()
            musicPlayer.play()
            
            sfxBite.prepareToPlay()
            sfxHeart.prepareToPlay()
            sfxDeath.prepareToPlay()
            sfxSkull.prepareToPlay()
            
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        
        startTimer()

    }
    
    
    
    func selectCharacter() {
        monsterImg.image = UIImage(named: "idle1.png")
        monsterImg.playIdleAnimation()
    }
    
    func itemDroppedOnCharacter(notif: NSNotification) {
      monsterHappy = true
       startTimer()
        
        foodImg.alpha = DIM_ALPHA
        foodImg.userInteractionEnabled = false
        heartImg.alpha = DIM_ALPHA
        heartImg.userInteractionEnabled = false
        
        if currentItem == 0 {
            sfxHeart.play()
        } else if currentItem == 1 {
            sfxBite.play()
        }
        
    }
    
    
    func startTimer() {
        if timer != nil {
            timer.invalidate()
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "changeGameState", userInfo: nil, repeats: true)
        
        
    }
    
    
    func changeGameState() {
        
        if !monsterHappy {
            penalties++
            
            sfxSkull.play()
            
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
        
        let rand = arc4random_uniform(2)
        
        if rand == 0 {
            foodImg.alpha = DIM_ALPHA
            foodImg.userInteractionEnabled = false
            
            heartImg.alpha = OPAQUE
            heartImg.userInteractionEnabled = true
        } else {
            heartImg.alpha = DIM_ALPHA
            heartImg.userInteractionEnabled = false
            
            foodImg.alpha = OPAQUE
            foodImg.userInteractionEnabled = true
        }
        
        currentItem = rand
        monsterHappy = false
        
    }
    
    
    
    
    func gameOver() {
        timer.invalidate()
        monsterImg.playDeathAnimation()
        sfxDeath.play()
        startOver()
    }
    
    func startOver() {
        print("Game Over")
        foodImg.alpha = DIM_ALPHA
        foodImg.userInteractionEnabled = false
        heartImg.alpha = DIM_ALPHA
        heartImg.userInteractionEnabled = false
        
        NSTimer.scheduledTimerWithTimeInterval(10.0, target: self, selector: "restartGame", userInfo: nil, repeats: false)

    }

    
    @IBAction func character1(sender: AnyObject) {
    }
    @IBAction func character2(sender: AnyObject) {
    }
    
    
    
}

