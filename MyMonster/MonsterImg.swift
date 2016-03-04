//
//  MonsterImg.swift
//  MyMonster
//
//  Created by Stephen Labedz on 3/4/16.
//  Copyright © 2016 Stephen Labedz. All rights reserved.
//

import Foundation
import UIKit


class MonsterImg: UIImageView {
   override init(frame: CGRect) {
    super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        playIdleAnimation()
    }
    
    
    
    func playIdleAnimation() {
        
        var imgArray = [UIImage]()
        
        for var x = 1; x <= 4; x++ {
            let img = UIImage(named: "idle\(x).png")
            imgArray.append(img!)
        }
        
        animationImages = imgArray
        animationDuration = 0.8
        animationRepeatCount = 0
        startAnimating()

        
    }
}