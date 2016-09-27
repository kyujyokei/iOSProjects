//
//  GameScene.swift
//  Solo Mission
//
//  Created by Kero on 2016/9/27.
//  Copyright (c) 2016年 Kero. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    
    let player = SKSpriteNode(imageNamed: "playerShip") // init player first for muti function access
    
    // init sfx globally to avoid lag, and move on to the next action right away
    let bulletSound = SKAction.playSoundFileNamed("shooting", waitForCompletion: false)
    
    
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    // generate random numbers within given range
    func random(min min:CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max-min) + min
    }
    
    
    let gameArea: CGRect
    
    
    // setting up game area so ship wont go out of iphone screen
    override init(size: CGSize) {
        
        let maxAspectRatio :CGFloat = 16.0/9.0
        let playableWidth = size.height / maxAspectRatio
        let margin = (size.width - playableWidth) / 2
        gameArea = CGRect(x: margin, y: 0, width: playableWidth, height: size.height)
        
        super.init(size: size)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    override func didMoveToView(view: SKView) { // rus as soon as scene loads up
        let background = SKSpriteNode(imageNamed: "background")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2 , y: self.size.height/2) // set position to the center point of the scene
        background.zPosition = 0 // put it in the lowest layer
        self.addChild(background)

        player.setScale(1)
        player.position = CGPoint(x: self.size.width/2 , y: self.size.height * 0.2)
        player.zPosition = 2
        self.addChild(player)
        
        startNewLevel()
    }
    
    
    func startNewLevel(){
    
        let spawn = SKAction.runBlock(spawnEnemy)
        let waitToSpawn = SKAction.waitForDuration(1)
        let spawnSequence = SKAction.sequence([spawn,waitToSpawn])
        let spawnForever = SKAction.repeatActionForever(spawnSequence)
        self.runAction(spawnForever)
    
    }
    
    
    
    func fireBullet() {
        
        let bullet = SKSpriteNode(imageNamed: "bullet")
        bullet.setScale(1)
        bullet.position = player.position // bullets fires where space ship is
        bullet.zPosition = 1
        self.addChild(bullet)
        
        // makes the bullet move to top of the screen in 1 sec
        let moveBullet = SKAction.moveToY(self.size.height + bullet.size.height, duration: 1)
        let deleteBullet = SKAction.removeFromParent() // removes the bullet when reaches target
        let bulletSequence = SKAction.sequence([bulletSound,moveBullet,deleteBullet])
        bullet.runAction(bulletSequence)
    }
    
    
    
    
    func spawnEnemy () {
        
        let randomXStart = random(min: CGRectGetMinX(gameArea), max: CGRectGetMaxX(gameArea))
        let randomXEnd = random(min: CGRectGetMinX(gameArea), max: CGRectGetMaxX(gameArea))
        
        let startPoint = CGPoint(x: randomXStart, y: self.size.height * 1.2)
        let endPoint = CGPoint(x: randomXEnd, y: -self.size.height * 0.2)
        
        let enemy = SKSpriteNode(imageNamed: "enemyShip")
        enemy.setScale(1)
        enemy.position = startPoint
        enemy.zPosition = 2
        self.addChild(enemy)
        
        let moveEnemy = SKAction.moveTo(endPoint, duration: 1.5)
        let deleteEnemy = SKAction.removeFromParent()
        let enemySequence = SKAction.sequence([moveEnemy,deleteEnemy])
        enemy.runAction(enemySequence)
        
        let dx = endPoint.x - startPoint.x
        let dy = endPoint.y - startPoint.y
        let amountToRotate = atan2(dy,dx)
        enemy.zRotation = amountToRotate
    }
    
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        fireBullet()
    }
    
    
    
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            
            let pointOfTouch = touch.locationInNode(self) // wherer we are touching now
            let previousPointOfTouch = touch.previousLocationInNode(self) // the place we were touching

            let amountDragged = pointOfTouch.x - previousPointOfTouch.x // calculate movement
            
            player.position.x += amountDragged
            
            // if the player exceeds game area
            if player.position.x > CGRectGetMaxX(gameArea) - player.size.width/2 {
                player.position.x = CGRectGetMaxX(gameArea) - player.size.width/2 // it stops
            }
            
            if player.position.x < CGRectGetMinX(gameArea) + player.size.width/2  {
                player.position.x = CGRectGetMinX(gameArea) + player.size.width/2  // it stops
            }
        }
    }
    
    
   }
