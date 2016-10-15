//
//  GameOverScene.swift
//  Solo Mission
//
//  Created by Kero on 2016/10/10.
//  Copyright © 2016年 Kero. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene{
    
    let restartLabel = SKLabelNode(fontNamed:"Hiruko Black Alternate")


    
    override func didMoveToView(view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2 , y: self.size.height/2) // set position to the center point of the scene
        background.zPosition = 0 // put it in the lowest layer
        self.addChild(background)
        
        let gameOverLabel = SKLabelNode(fontNamed:"Hiruko Black Alternate")
        gameOverLabel.text = "Game Over"
        gameOverLabel.fontSize = 200
        gameOverLabel.fontColor = SKColor.whiteColor()
        gameOverLabel.position = CGPoint(x:self.size.width*0.5, y: self.size.height*0.7)
        gameOverLabel.zPosition = 1
        self.addChild(gameOverLabel)
        
        let scoreLabel = SKLabelNode(fontNamed:"Hiruko Black Alternate")
        scoreLabel.text = "Score:\(gameScore)"
        scoreLabel.fontSize = 125
        scoreLabel.fontColor = SKColor.whiteColor()
        scoreLabel.position = CGPoint(x:self.size.width*0.5, y: self.size.height*0.55)
        scoreLabel.zPosition = 1
        self.addChild(scoreLabel)
        
        let defaults = NSUserDefaults()
        var highScoreNumber = defaults.integerForKey("highScoreSaved")
        
        if gameScore > highScoreNumber{
            highScoreNumber = gameScore
            defaults.setInteger(highScoreNumber, forKey: "highScoreSaved")
        }
        
        let highScoreLabel = SKLabelNode(fontNamed:"Hiruko Black Alternate")
        highScoreLabel.text = "High Score:\(highScoreNumber)"
        highScoreLabel.fontSize = 125
        highScoreLabel.fontColor = SKColor.whiteColor()
        highScoreLabel.position = CGPoint(x:self.size.width*0.5, y: self.size.height*0.45)
        highScoreLabel.zPosition = 1
        self.addChild(highScoreLabel)
        
        restartLabel.text = "Restart"
        restartLabel.fontSize = 90
        restartLabel.fontColor = SKColor.whiteColor()
        restartLabel.zPosition = 1
        restartLabel.position = CGPoint(x:self.size.width*0.5, y: self.size.height*0.3)
        self.addChild(restartLabel)
        

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch: AnyObject in touches{
            
            let pointOfTouch = touch.locationInNode(self) // this is a CGPoint
            if restartLabel.containsPoint(pointOfTouch){ // if restart label includes the touch point
            
                let sceneToMoveTo = GameScene(size:self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fadeWithDuration(0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }
            
        
        }
        
    }



}