//
//  GameScene.swift
//  Solo Mission
//
//  Created by Kero on 2016/9/27.
//  Copyright (c) 2016年 Kero. All rights reserved.
//

import SpriteKit

var gameScore = 0 // keeps track of the score

class GameScene: SKScene, SKPhysicsContactDelegate {
    

    let scoreLabel = SKLabelNode(fontNamed: "Hiruko Black Alternate")
    
    var livesNumber = 3
    let livesLabel = SKLabelNode(fontNamed: "Hiruko Black Alternate")
    
    let tapToStartLabel = SKLabelNode(fontNamed: "Hiruko Black Alternate")
    
    var levelNumber = 0
    
    
    let player = SKSpriteNode(imageNamed: "playerShip") // init player first for muti function access
    
    // init sfx globally to avoid lag, and move on to the next action right away
    let bulletSound = SKAction.playSoundFileNamed("shooting", waitForCompletion: false)
    let explosionSound = SKAction.playSoundFileNamed("explosion", waitForCompletion: false)
    
    enum gameState{
        case preGame //  before game starts
        case inGame // during the game
        case afterGame // when game's finished
    }
    
    var currentGameState = gameState.preGame
    
    struct PhysicsCategories{
        static let None : UInt32 = 0
        static let Player : UInt32 = 0b1 //1
        static let Bullet : UInt32 = 0b10 //2
        static let Enemy : UInt32 = 0b100 //4
    }
    
    
    
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
        
        gameScore = 0
        
        self.physicsWorld.contactDelegate = self
        
        for i in 0...1{ // creates 2 backgorunds for scrolling
            
            let background = SKSpriteNode(imageNamed: "background")
            background.size = self.size
            background.anchorPoint = CGPoint(x: 0.5, y: 0) // set the anchor point to the bottom center for better scrolling
            background.position = CGPoint(x: self.size.width/2 ,
                                          y: self.size.height*CGFloat(i)) // set different coordinates for 2 bgs
            background.zPosition = 0 // put it in the lowest layer
            self.addChild(background)
            
        }

        player.setScale(1)
        player.position = CGPoint(x: self.size.width/2 , y: 0 - self.size.height)
        player.zPosition = 2
        player.physicsBody = SKPhysicsBody(rectangleOfSize: player.size) // set physics body to player
        player.physicsBody!.affectedByGravity = false
        player.physicsBody?.categoryBitMask = PhysicsCategories.Player
        player.physicsBody?.collisionBitMask = PhysicsCategories.None
        player.physicsBody?.contactTestBitMask = PhysicsCategories.Enemy
        self.addChild(player)
        
        scoreLabel.text = "Score:0"
        scoreLabel.fontSize = 70
        scoreLabel.fontColor = SKColor.whiteColor()
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        scoreLabel.position = CGPoint(x: self.size.width*0.15 , y: self.size.height + scoreLabel.frame.size.height)
        scoreLabel.zPosition = 100 // always on the very top
        self.addChild(scoreLabel)
        
        livesLabel.text = "Lives: 3"
        livesLabel.fontSize = 70
        livesLabel.fontColor = SKColor.whiteColor()
        livesLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Right
        livesLabel.position = CGPoint(x: self.size.width*0.85 , y: self.size.height + livesLabel.frame.size.height)
        livesLabel.zPosition = 100 // always on the very top
        self.addChild(livesLabel)
        
        let moveOnToScren = SKAction.moveToY(self.size.height*0.9, duration: 0.5) // makes these labels fade in from the top
        scoreLabel.runAction(moveOnToScren)
        livesLabel.runAction(moveOnToScren)
        
        tapToStartLabel.text = "Tap to Begin"
        tapToStartLabel.fontSize = 100
        tapToStartLabel.fontColor = SKColor.whiteColor()
        tapToStartLabel.zPosition = 1
        tapToStartLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        tapToStartLabel.alpha = 0 // tranparent at the start
        self.addChild(tapToStartLabel)
        
        let fadeInAction = SKAction.fadeInWithDuration(0.5) // fade in action for tapToStartLabel
        tapToStartLabel.runAction(fadeInAction)
        
    }
    
    var lastUpdateTime:NSTimeInterval = 0 // stores time of the last frame to calculate delta time
    var deltaFrameTime:NSTimeInterval = 0
    var amountToMovePerSec : CGFloat = 600.0
    
    override func update(currentTime: NSTimeInterval) { // runs once per frame
        
        if lastUpdateTime == 0{ // first time running
            lastUpdateTime = currentTime
        }else{
            deltaFrameTime = currentTime - lastUpdateTime
            lastUpdateTime = currentTime
        }
        
        
    }
    
    
    func startGame(){
        currentGameState = gameState.inGame
        
        let fadeOutAction = SKAction.fadeOutWithDuration(0.5)
        let deleteAction = SKAction.removeFromParent()
        let deleteSequence = SKAction.sequence([fadeOutAction,deleteAction])
        tapToStartLabel.runAction(deleteSequence)
        
        let moveShipToScreenAction = SKAction.moveToY(self.size.height*0.2, duration: 0.5)
        let startLevelAction = SKAction.runBlock(startNewLevel)
        let startGameSequence = SKAction.sequence([moveShipToScreenAction, startLevelAction])
        player.runAction(startGameSequence)
        
        
    }
    
    func loseALife(){
        
        livesNumber -= 1
        livesLabel.text = "Lives: \(livesNumber)"
        
        let scaleUp = SKAction.scaleTo(1.5, duration: 0.2)
        let scaleDown = SKAction.scaleTo(1, duration: 0.2)
        let scaleSequence = SKAction.sequence([scaleUp,scaleDown])
        livesLabel.runAction(scaleSequence)
        
        if livesNumber == 0 {
            runGameOver()
        }
        
    }
    
    
    func addScore(){
        
        gameScore += 1
        scoreLabel.text = "Score: \(gameScore)"
        
        if gameScore == 10 || gameScore == 25 || gameScore == 50 {
            startNewLevel()
        }
    
    }
    
    
    func runGameOver(){
        
        currentGameState = gameState.afterGame
        
        self.removeAllActions()
        
        self.enumerateChildNodesWithName("Bullet"){ // generate a list of all the objects with the name "Bullet"
            bullet, stop in // call each bullet
            bullet.removeAllActions()
        }
        
        self.enumerateChildNodesWithName("Enemy"){
            enemy, stop in
            enemy.removeAllActions()
        }
        
        let changeSceneAction = SKAction.runBlock(changeScene)
        let waitToChangeScene = SKAction.waitForDuration(1)
        let changeSceneSequence = SKAction.sequence([changeSceneAction,waitToChangeScene])
        self.runAction(changeSceneSequence)
    
    }
    
    
    func changeScene(){
        
        let sceneToMoveTo = GameOverScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fadeWithDuration(0.5)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
        
    
    }
    
    
    
    // runs when 2 physics body A contacts with defined type B
    func didBeginContact(contact: SKPhysicsContact) {
        
        var body1 = SKPhysicsBody()
        var body2 = SKPhysicsBody()
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask{
            body1 = contact.bodyA
            body2 = contact.bodyB
        } else {
            body1 = contact.bodyB
            body2 = contact.bodyA
        }
        
        if body1.categoryBitMask == PhysicsCategories.Player && body2.categoryBitMask == PhysicsCategories.Enemy {
            // if player hit enemy
            
            if body1.node != nil{
            spawnExplosion(body1.node!.position)
            }
            if body2.node != nil{
            spawnExplosion(body2.node!.position)
            }
                
            body1.node?.removeFromParent()
            body2.node?.removeFromParent()
            
            runGameOver()
        }
        
        if body1.categoryBitMask == PhysicsCategories.Bullet && body2.categoryBitMask == PhysicsCategories.Enemy && body2.node?.position.y < self.size.height {
            // if bullet hit enemy
            
            addScore()
            
            if body2.node != nil{
            spawnExplosion(body2.node!.position)
            }
                
            body1.node?.removeFromParent()
            body2.node?.removeFromParent()
        }
        
    }
    
    
    func spawnExplosion(spawnPosition:CGPoint){
        
        let explosion = SKSpriteNode(imageNamed: "explosion")
        explosion.position = spawnPosition
        explosion.zPosition = 3
        explosion.setScale(0) // start very small
        self.addChild(explosion)
    
        let scaleIn = SKAction.scaleTo(1, duration: 0.1)
        let fadeOut = SKAction.fadeOutWithDuration(0.1)
        let delete = SKAction.removeFromParent()
        let explosionSequence = SKAction.sequence([explosionSound,scaleIn,fadeOut,delete])
        
        explosion.runAction(explosionSequence)
        
    }
    
    
    func startNewLevel(){
        
        levelNumber += 1
        
        if self.actionForKey("spawningEnemies") != nil {
            self.removeActionForKey("spawningEnemies")
        }
        
        var levelDuration = NSTimeInterval()
        
        switch levelNumber {
        case 1: levelDuration = 1.2
        case 2: levelDuration = 1.0
        case 3: levelDuration = 0.8
        case 4: levelDuration = 0.5
        default:
            levelDuration = 0.5
            print("Cannot find level info")
        
        }
    
        let spawn = SKAction.runBlock(spawnEnemy)
        let waitToSpawn = SKAction.waitForDuration(levelDuration)
        let spawnSequence = SKAction.sequence([waitToSpawn,spawn])
        let spawnForever = SKAction.repeatActionForever(spawnSequence)
        self.runAction(spawnForever, withKey: "spawningEnemies")
    
    }
    
    
    
    func fireBullet() {
        
        let bullet = SKSpriteNode(imageNamed: "bullet")
        bullet.name = "Bullet" // reference name
        bullet.setScale(1)
        bullet.position = player.position // bullets fires where space ship is
        bullet.zPosition = 1
        bullet.physicsBody = SKPhysicsBody(rectangleOfSize: bullet.size)
        bullet.physicsBody!.affectedByGravity = false
        bullet.physicsBody?.categoryBitMask = PhysicsCategories.Bullet
        bullet.physicsBody?.collisionBitMask = PhysicsCategories.None
        bullet.physicsBody?.contactTestBitMask = PhysicsCategories.Enemy
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
        enemy.name = "Enemy"
        enemy.setScale(1)
        enemy.position = startPoint
        enemy.zPosition = 2
        enemy.physicsBody = SKPhysicsBody(rectangleOfSize: enemy.size)
        enemy.physicsBody!.affectedByGravity = false
        enemy.physicsBody?.categoryBitMask = PhysicsCategories.Enemy
        enemy.physicsBody!.collisionBitMask = PhysicsCategories.None
        enemy.physicsBody?.contactTestBitMask = PhysicsCategories.Player | PhysicsCategories.Bullet
        self.addChild(enemy)
        
        let moveEnemy = SKAction.moveTo(endPoint, duration: 1.5)
        let deleteEnemy = SKAction.removeFromParent()
        let loseALifeAction = SKAction.runBlock(loseALife)
        let enemySequence = SKAction.sequence([moveEnemy,deleteEnemy,loseALifeAction])
        
        if currentGameState == gameState.inGame{
            enemy.runAction(enemySequence) 
        }
            
        let dx = endPoint.x - startPoint.x
        let dy = endPoint.y - startPoint.y
        let amountToRotate = atan2(dy,dx)
        enemy.zRotation = amountToRotate
    }
    
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if currentGameState == gameState.preGame{
            startGame()
        }
        
        else if currentGameState == gameState.inGame{
            fireBullet()
        }
    }
    
    
    
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            
            let pointOfTouch = touch.locationInNode(self) // wherer we are touching now
            let previousPointOfTouch = touch.previousLocationInNode(self) // the place we were touching

            let amountDragged = pointOfTouch.x - previousPointOfTouch.x // calculate movement
            
            if currentGameState == gameState.inGame{
                player.position.x += amountDragged // moves spaceship when dragged
            }
            
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
