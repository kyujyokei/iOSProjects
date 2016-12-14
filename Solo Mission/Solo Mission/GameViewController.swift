//
//  GameViewController.swift
//  Solo Mission
//
//  Created by Kero on 2016/9/27.
//  Copyright (c) 2016年 Kero. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class GameViewController: UIViewController {
    
    var backingAudio = AVAudioPlayer()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting up bgm
        print("Hi")
        let filePath = NSBundle.mainBundle().pathForResource("Sugar", ofType: "mp3")
        let audioNSURL = NSURL(fileURLWithPath: filePath!)
        
        do {
            backingAudio = try AVAudioPlayer (contentsOfURL: audioNSURL)}
        catch {return print("Cannot find audio for bgm")}
        
        backingAudio.numberOfLoops = -1 // loop forever
        backingAudio.volume = 0.5 // 1 is normal and 0 is mute
        backingAudio.play()
        
        

        let scene = MainMenuScene(size: CGSize(width: 1536, height: 2048))
        // this makes the game to auto re-scale to let every images fit
        
        // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true // set these to false to hide them at the right bottom of the screen
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
