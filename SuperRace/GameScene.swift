//
//  GameScene.swift
//  SuperRace
//
//  Created by FloodSurge on 6/19/14.
//  Copyright (c) 2014 FloodSurge. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {

    var car:SKSpriteNode!
    let track = Track()
    override func didMoveToView(view: SKView) {
        
        basicConfig()
        configTrack()
        addCar()
        
        
    }
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!)
    {
        //car.runAction(SKAction.moveByX(0, y: 50, duration: 0.1))
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        
        track.update()
    }
    
    func basicConfig(){
        backgroundColor = UIColor.blackColor()
        
        physicsWorld.gravity = CGVectorMake(0, -3)

    }
    
    
    func addCar()
    {
        
        let carTexture = SKTexture(imageNamed:"car")
        car = SKSpriteNode(texture:carTexture)
        //car.zPosition = 1
        car.physicsBody = SKPhysicsBody(texture:carTexture,size:car.size)
        car.position = CGPointMake(size.width/2, size.height/2)
        addChild(car)

    }
    
    func configTrack()
    {
        track.position = CGPointMake(512, 384)
        //track.zPosition = 0
        //track.setScale(2)
        addChild(track)

    }
    
}
