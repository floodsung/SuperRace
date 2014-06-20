//
//  Track.swift
//  FallingEgg
//
//  Created by FloodSurge on 6/19/14.
//  Copyright (c) 2014 FloodSurge. All rights reserved.
//

import SpriteKit
import CoreMotion

enum TrackPartType {
    case LeftDown
    case LeftRight
    case LeftUp
    case RightDown
    case RightUp
    case UpDown
}


class Track:SKNode {
    
    var lastPartType:TrackPartType = .UpDown
    var lastPartPosition:CGPoint = CGPointZero
    
    
    func update()
    {
        let motionManager = MotionDetector.sharedInstance.motionManager
        
        let yaw = motionManager.deviceMotion.attitude.yaw
            
        
    }
    
    init()
    {
        super.init()
        
        addPart(.UpDown, position: CGPointMake(0, 300))
        addPart(.UpDown, position: CGPointMake(0, 0))
        addPart(.LeftUp, position: CGPointMake(0, -300))
        addPart(.RightUp, position: CGPointMake(-300, -300))
    }
    
    
    func addPart(type:TrackPartType,position:CGPoint){
        lastPartType = type
        lastPartPosition = position
        switch type {
        case .LeftDown :
            addPartWithTextures("trackLeftDownIn", texture2Name: "trackLeftDownOut", position: position)
        case .LeftRight:
            addPartWithTextures("trackLeftRightDown", texture2Name: "trackLeftRightUp", position: position)
        case .LeftUp:
            addPartWithTextures("trackLeftUpIn", texture2Name: "trackLeftUpOut", position: position)
        case .RightDown:
            addPartWithTextures("trackRightDownIn", texture2Name: "trackRightDownOut", position: position)
        case .RightUp:
            addPartWithTextures("trackRightUpIn", texture2Name: "trackRightUpOut", position: position)
        case .UpDown:
            addPartWithTextures("trackUpDownLeft", texture2Name: "trackUpDownRight", position: position)
            
            
        }
    }
    
    func addPartWithTextures(texture1Name:String,texture2Name:String,position:CGPoint)
    {
        let part1Texture = SKTexture(imageNamed:texture1Name)
        let part2Texture = SKTexture(imageNamed:texture2Name)
        let part1 = SKSpriteNode(texture:part1Texture)
        let part2 = SKSpriteNode(texture:part2Texture)
        
        part1.position = position
        part2.position = position

        
        part1.physicsBody = SKPhysicsBody(texture:part1Texture,size:part1.size)
        part2.physicsBody = SKPhysicsBody(texture:part2Texture,size:part2.size)
        part1.physicsBody.dynamic = false
        part2.physicsBody.dynamic = false
        
        addChild(part1)
        addChild(part2)
        
        
        let backgroundTexture = SKTexture(imageNamed:"trackBackground")
        let background = SKSpriteNode(texture:backgroundTexture)
        background.zPosition = -1
        background.position = position
        addChild(background)

        
    }
    
}
