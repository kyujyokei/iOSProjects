//
//  MLMovingGround.swift
//  NimbleNInja
//
//  Created by Kero on 2016/5/14.
//  Copyright © 2016年 Kero. All rights reserved.
//

import Foundation
import SpriteKit

class MLMovingGround: SKSpriteNode {
    
    let NUMBER_OF_SEGMENTS = 20
    let COLOR_ONE = UIColor.yellowColor()
    let COLOR_TWO = UIColor.blueColor()
    
    init(size: CGSize){
        super.init(texture: nil, color: UIColor.brownColor(), size: CGSizeMake(size.width*2, size.height))
        anchorPoint = CGPointMake(0, 0.5)
        
        for var i = 0 ; i < NUMBER_OF_SEGMENTS ; i+=1 {
            var segmentColor:UIColor!
            if i % 2 == 0 {
                segmentColor = COLOR_ONE
            } else {
                segmentColor = COLOR_TWO
            }
            
            let segment = SKSpriteNode(color: segmentColor, size: CGSizeMake(self.size.width / CGFloat(NUMBER_OF_SEGMENTS), self.size.height))
            segment.anchorPoint = CGPointMake(0, 0.5)
            segment.position = CGPointMake(CGFloat(i)*segment.size.width, )
        }
        
    }


    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

