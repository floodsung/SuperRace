//
//  GameScene.swift
//  SuperRace
//
//  Created by FloodSurge on 6/19/14.
//  Copyright (c) 2014 FloodSurge. All rights reserved.
//

import SpriteKit

class GameScene: SKScene,SKPhysicsContactDelegate {

    var car:SKSpriteNode!
    var scoreLabel:SKLabelNode!
    var track:Track!
    var lastUpdateTime:CFTimeInterval = 0.0
    
    override func didMoveToView(view: SKView) {
        
        basicConfig()
        configTrack()
        addCar()
        addScoreLabel()
        
        runAction(SKAction.repeatActionForever(SKAction.playSoundFileNamed("bgMusic.mp3", waitForCompletion: true)))
        
    }
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!)
    {
        if paused {
            //removeAllActions()
            
            removeAllChildren()
            
            paused = false
            basicConfig()
            configTrack()
            addCar()
            addScoreLabel()
            
            SRMotionDetector.sharedInstance().stopUpdate()
            SRMotionDetector.sharedInstance().startUpdate()
            //SRMotionDetector.sharedInstance().startDetect()
            
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        println("updateTime:\(currentTime - lastUpdateTime)")
        lastUpdateTime = currentTime
        
        if track.xScale == 2 {
           track.update()
        }
        
        scoreLabel.text = "Score: \(track.count - 2)"
    }
    
    func basicConfig(){
        backgroundColor = UIColor.blackColor()
        
        physicsWorld.gravity = CGVectorMake(0, 0)
        physicsWorld.contactDelegate = self
    }
    
    func addScoreLabel()
    {
        scoreLabel = SKLabelNode(fontNamed: "Marker Felt")
        scoreLabel.text = "Score: 0"
        scoreLabel.zPosition = 10
        scoreLabel.position = CGPointMake(size.width/8, size.height - 100)
        
        //scoreLabel.runAction(SKAction.fadeInWithDuration(0.5))
        
        addChild(scoreLabel)

    }
    
    func addCar()
    {
        
        let carTexture = SKTexture(imageNamed:"car")
        car = SKSpriteNode(texture:carTexture)
        //car.zPosition = 1
        car.physicsBody = SKPhysicsBody(texture:carTexture,size:car.size)
        car.position = CGPointMake(size.width/2, size.height/2)
        car.physicsBody.categoryBitMask = 1
        car.physicsBody.collisionBitMask = 2
        car.physicsBody.contactTestBitMask = 2
        addChild(car)

    }
    
    func configTrack()
    {
        track = Track()
        track.position = CGPointMake(512, 384)
        //track.zPosition = 0
        track.setScale(9)
        
        
        track.runAction(SKAction.scaleTo(2, duration: 1))
                
        addChild(track)

    }
    
    func didBeginContact(contact: SKPhysicsContact!)
    {
        let failLabel = SKLabelNode(fontNamed: "Marker Felt")
        failLabel.text = "You Lose"
        failLabel.fontSize = 100
        failLabel.fontColor = UIColor.whiteColor()
        failLabel.zPosition = 10
        
        failLabel.position = CGPointMake(size.width/2, size.height/2)
        
        failLabel.runAction(SKAction.fadeInWithDuration(0.5))
        
        addChild(failLabel) 
        
        runAction(SKAction.waitForDuration(0.5))
        
        paused = true
        
        //SRMotionDetector.sharedInstance().stopDetect()
        //SRMotionDetector.sharedInstance().stopUpdate()

    }
    
}
