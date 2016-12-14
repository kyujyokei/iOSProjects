//
//  MainMenuScene.swift
//  Solo Mission
//
//  Created by Kero on 2016/10/15.
//  Copyright © 2016年 Kero. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenuScene : SKScene{

    override func didMoveToView(view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        let gameBy = SKLabelNode(fontNamed:"Hiruko Black Alternate")
        gameBy.text = "Kejo Hsieh's"
        gameBy.fontSize = 50
        gameBy.fontColor = SKColor.whiteColor()
        gameBy.position = CGPoint(x: self.size.width/2, y: self.size.height*0.78)
        gameBy.zPosition = 1
        self.addChild(gameBy)
        
        let gameTitleUpper = SKLabelNode(fontNamed:"Hiruko Black Alternate")
        gameTitleUpper.text = "Solo"
        gameTitleUpper.fontSize = 200
        gameTitleUpper.fontColor = SKColor.whiteColor()
        gameTitleUpper.position = CGPoint(x: self.size.width/2, y: self.size.height*0.7)
        gameTitleUpper.zPosition = 1
        self.addChild(gameTitleUpper)
        
        let gameTitleLower = SKLabelNode(fontNamed:"Hiruko Black Alternate")
        gameTitleLower.text = "Mission"
        gameTitleLower.fontSize = 200
        gameTitleLower.fontColor = SKColor.whiteColor()
        gameTitleLower.position = CGPoint(x: self.size.width/2, y: self.size.height*0.625)
        gameTitleLower.zPosition = 1
        self.addChild(gameTitleLower)
        
        let startGame = SKLabelNode(fontNamed:"Hiruko Black Alternate")
        startGame.text = "Start Game"
        startGame.fontSize = 150
        startGame.fontColor = SKColor.whiteColor()
        startGame.position = CGPoint(x: self.size.width/2, y: self.size.height*0.4)
        startGame.zPosition = 1
        startGame.name = "startButton"
        self.addChild(startGame)
  
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch: AnyObject in touches {
        
            let pointOfTouch = touch.locationInNode(self)
            let nodeITapped = nodeAtPoint(pointOfTouch)
            
            if nodeITapped.name == "startButton"{
                
                let sceneToMoveTo = GameScene(size:self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fadeWithDuration(0.5)
                self.view!.presentScene(sceneToMoveTo,transition: myTransition)
                
            }
        }
        
    }


}