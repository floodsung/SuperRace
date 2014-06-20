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

enum TrackDirection{
    case Up
    case Down
    case Left
    case Right
}

let TRACK_PART_WIDTH:CGFloat = 300

class Track:SKNode {
    
    var count = 0
    var lastPart:TrackPart!
    
    func update()
    {
        // 1 rotate and move the sprites
        let motionManager = MotionDetector.sharedInstance.motionManager
        
        let yaw = motionManager.deviceMotion.attitude.yaw
            
        let rotateAction = SKAction.rotateToAngle(CGFloat(-yaw), duration: 0)
        let move = CGVectorMake(CGFloat(-4*sin(CDouble(zRotation))),CGFloat(-4*cos(CDouble(zRotation))))
        
        let moveAction = SKAction.moveBy(move, duration: 0)
        
        for sprite : AnyObject in children {
            (sprite as SKNode).runAction(moveAction)
        }
        
        runAction(rotateAction)
        
        // add and remove track part
        
        for node:AnyObject in children {
            
            let part  = node as TrackPart
            if fabs(CDouble(part.position.x)) < 150 && fabs(CDouble(part.position.y)) < 150 {
                println("part NO: \(part.count)")
                
                if count - part.count < 3 {
                    createNextPart()
                }
                
                if part.count > 4 {
                   for node:AnyObject in children {
                    
                        let littlePart = node as TrackPart
                    if littlePart.count < part.count - 3{
                        littlePart.runAction(SKAction.removeFromParent())
                    }
                    }
                    
                }
                
            }
        }
        
       
        
        
        
        
            
        
        
        
    }
    
    func createNextPart()
    {
        let choice = arc4random() % 99
        
        var nextPart:TrackPart
        switch lastPart.direction{
        case .Up:
            switch choice {
            case 0..50 :
                nextPart = TrackPart(type: .UpDown, direction: .Up, position: nextPosition(.Up, lastNode: lastPart),count:++count)
            case 50..75:
                nextPart = TrackPart(type: .LeftDown, direction: .Left, position: nextPosition(.Up, lastNode: lastPart),count:++count)
            default:
                nextPart = TrackPart(type: .RightDown, direction: .Right, position: nextPosition(.Up, lastNode: lastPart),count:++count)
                
            }
            
        case .Down:
            switch choice {
            case 0..50 :
                nextPart = TrackPart(type: .UpDown, direction: .Down, position: nextPosition(.Down, lastNode: lastPart),count:++count)
            case 50..75:
                nextPart = TrackPart(type: .LeftUp, direction: .Left, position: nextPosition(.Down, lastNode: lastPart),count:++count)
            default:
                nextPart = TrackPart(type: .RightUp, direction: .Right, position: nextPosition(.Down, lastNode: lastPart),count:++count)
                
            }
            
        case .Left:
            switch choice {
            case 0..50 :
                nextPart = TrackPart(type: .LeftRight, direction: .Left, position: nextPosition(.Left, lastNode: lastPart),count:++count)
            case 50..75:
                nextPart = TrackPart(type: .RightUp, direction: .Up, position: nextPosition(.Left, lastNode: lastPart),count:++count)
            default:
                nextPart = TrackPart(type: .RightDown, direction: .Down, position: nextPosition(.Left, lastNode: lastPart),count:++count)
                
            }
            
        case .Right:
            switch choice {
            case 0..50 :
                nextPart = TrackPart(type: .LeftRight, direction: .Right, position: nextPosition(.Right, lastNode: lastPart),count:++count)
            case 50..75:
                nextPart = TrackPart(type: .LeftUp, direction: .Up, position: nextPosition(.Right, lastNode: lastPart),count:++count)
            default:
                nextPart = TrackPart(type: .LeftDown, direction: .Down, position: nextPosition(.Right, lastNode: lastPart),count:++count)
                
            }
            
            
        }
        
        addChild(nextPart)
        
        lastPart = nextPart
    }
    
    init()
    {
        super.init()
        
        addInitParts()
        
        
        
    }
    
    func addInitParts()
    {
        let part1 = TrackPart(type: .UpDown, direction: .Up, position: CGPointMake(0, -TRACK_PART_WIDTH),count:++count)
        addChild(part1)
        lastPart = part1
        
        
        let part2 = TrackPart(type: .UpDown, direction: .Up, position: nextPosition(.Up, lastNode: lastPart),count:++count
        )
        addChild(part2)
        lastPart = part2
        
        let part3 = TrackPart(type: .RightDown, direction: .Right, position: nextPosition(.Up, lastNode: lastPart),count:++count)
        addChild(part3)
    
        lastPart = part3
    

    }
    
    
    func nextPosition(direction:TrackDirection,lastNode:SKNode)->CGPoint
    {
        let offsetSin = TRACK_PART_WIDTH * CGFloat(sin(CDouble(lastNode.zRotation)))
        let offsetCos = TRACK_PART_WIDTH * CGFloat(cos(CDouble(lastNode.zRotation)))
        
        switch direction{
        case .Up:
            return CGPointMake(lastNode.position.x + offsetSin, lastNode.position.y + offsetCos)
        case .Down:
            return CGPointMake(lastNode.position.x - offsetSin, lastNode.position.y - offsetCos)
        case .Left:
            return CGPointMake(lastNode.position.x - offsetCos, lastNode.position.y + offsetSin)
        case .Right:
            return CGPointMake(lastNode.position.x + offsetCos, lastNode.position.y - offsetSin)

        }
    }
    
}



class TrackPart:SKNode
{
    let type:TrackPartType
    let direction:TrackDirection
    let count:Int
    
    init(type:TrackPartType,direction:TrackDirection,position:CGPoint,count:Int)
    {
        self.type = type
        self.direction = direction
        self.count = count
        super.init()
        
        self.position = position
        name = "TrackPart"
        addPart(type)
        
    }
    
    func addPart(type:TrackPartType){
        
        switch type {
        case .LeftDown :
            addPartWithTextures("trackLeftDownIn", texture2Name: "trackLeftDownOut")
        case .LeftRight:
            addPartWithTextures("trackLeftRightDown", texture2Name: "trackLeftRightUp")
        case .LeftUp:
            addPartWithTextures("trackLeftUpIn", texture2Name: "trackLeftUpOut")
        case .RightDown:
            addPartWithTextures("trackRightDownIn", texture2Name: "trackRightDownOut")
        case .RightUp:
            addPartWithTextures("trackRightUpIn", texture2Name: "trackRightUpOut")
        case .UpDown:
            addPartWithTextures("trackUpDownLeft", texture2Name: "trackUpDownRight")
            
            
        }
    }
    
    
    func addPartWithTextures(texture1Name:String,texture2Name:String)
    {
        let part1Texture = SKTexture(imageNamed:texture1Name)
        let part2Texture = SKTexture(imageNamed:texture2Name)
        let part1 = SKSpriteNode(texture:part1Texture)
        let part2 = SKSpriteNode(texture:part2Texture)
        
        part1.physicsBody = SKPhysicsBody(texture:part1Texture,size:part1.size)
        part2.physicsBody = SKPhysicsBody(texture:part2Texture,size:part2.size)
        part1.physicsBody.dynamic = false
        part2.physicsBody.dynamic = false
        
        addChild(part1)
        addChild(part2)
        
        
        let backgroundTexture = SKTexture(imageNamed:"trackBackground")
        let background = SKSpriteNode(texture:backgroundTexture)
        background.zPosition = -1
        addChild(background)
    }

}
