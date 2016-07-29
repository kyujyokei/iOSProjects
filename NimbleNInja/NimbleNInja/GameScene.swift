//
//  GameScene.swift
//  NimbleNInja
//
//  Created by Kero on 2016/5/14.
//  Copyright (c) 2016年 Kero. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
       backgroundColor = UIColor(red: 159.0/255, green: 201.0/255, blue: 244.8/255, alpha: 1.0)
        
        let ground = MLMovingGround(size: CGSizeMake(view.frame.width, 20))
        ground.position = view.center
        addChild(ground)
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
  
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
