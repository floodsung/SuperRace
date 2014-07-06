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

let TRACK_PART_WIDTH:CGFloat = 300.0

class Track:SKNode {
    
    var count = 0
    var lastPart:TrackPart!
    var velocity = 4.0
    
    
    
    func addAndRemoveParts()
    {
        // add and remove track part
        //var currentCount:Int?
        for i in 0..children.count {
            
            let part  = children[i] as TrackPart
            if part.containsPoint(CGPointZero) {
                
                //currentCount = part.count
                if count - part.count < 2 {
                    //println("current part direction: \(part.direction)")
                    createNextPart()
                    if i > 2 {
                        (children[i-1] as TrackPart).zPosition = -10
                        (children[i-1] as TrackPart).setPhysicsBodyNil()

                    }
                    
                }
                
                break
           
            }
        }
        
    /*
        if let aCount = currentCount {
            
            for node:AnyObject in children {
                let part  = node as TrackPart
                if part.count == aCount - 1 {
                    println("delete \(part.count)")
                    part.zPosition = -10
                    part.setPhysicsBodyNil()
                }
            }
        }
    */
    }
    
    func update()
    {
        
        if count % 10 == 0 {
            velocity += 0.01
        }
        
        let yaw = SRMotionDetector.sharedInstance().rotationDegree()
        
        
        
        //println("zRotation:\(zRotation)")
        
        addAndRemoveParts()
        
        let move = CGVectorMake(CGFloat(-velocity*sin(CDouble(zRotation))),CGFloat(-velocity*cos(CDouble(zRotation))))
        
        let moveAction = SKAction.moveBy(move, duration: 0)
        
        for sprite : AnyObject in children {
            (sprite as SKNode).runAction(moveAction)
        }

        zRotation = CGFloat(-yaw)

        
   
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
        
        createNextPart()


    }
    
    
    func nextPosition(direction:TrackDirection,lastNode:SKNode)->CGPoint
    {
        
        switch direction{
        case .Up:
            return CGPointMake(lastNode.position.x, lastNode.position.y + TRACK_PART_WIDTH)
        case .Down:
            return CGPointMake(lastNode.position.x, lastNode.position.y - TRACK_PART_WIDTH)
        case .Left:
            return CGPointMake(lastNode.position.x - TRACK_PART_WIDTH, lastNode.position.y)
        case .Right:
            return CGPointMake(lastNode.position.x + TRACK_PART_WIDTH, lastNode.position.y)

        }
    }
    
}

let trackLeftDownInTexture = SKTexture(imageNamed:"trackLeftDownIn")
let trackLeftDownOutTexture = SKTexture(imageNamed:"trackLeftDownOut")
let trackLeftRightDownTexture = SKTexture(imageNamed:"trackLeftRightDown")
let trackLeftRightUpTexture = SKTexture(imageNamed:"trackLeftRightUp")
let trackLeftUpInTexture = SKTexture(imageNamed:"trackLeftUpIn")
let trackLeftUpOutTexture = SKTexture(imageNamed:"trackLeftUpOut")
let trackRightDownInTexture = SKTexture(imageNamed:"trackRightDownIn")
let trackRightDownOutTexture = SKTexture(imageNamed:"trackRightDownOut")
let trackRightUpInTexture = SKTexture(imageNamed:"trackRightUpIn")
let trackRightUpOutTexture = SKTexture(imageNamed:"trackRightUpOut")
let trackUpDownLeftTexture = SKTexture(imageNamed:"trackUpDownLeft")
let trackUpDownRightTexture = SKTexture(imageNamed:"trackUpDownRight")
let backgroundTexture = SKTexture(imageNamed:"trackBackground")


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

        runAction(SKAction.sequence([SKAction.waitForDuration(5),SKAction.removeFromParent()]))
        
    }
    
    func setPhysicsBodyNil(){
        for child:AnyObject in children {
            (child as SKNode).physicsBody = nil
        }
    }
    
    func addPart(type:TrackPartType){
        
        switch type {
        case .LeftDown :
            addPartWithTextures( trackLeftDownInTexture, texture2: trackLeftDownOutTexture)
        case .LeftRight:
            addPartWithTextures(trackLeftRightDownTexture, texture2: trackLeftRightUpTexture)
        case .LeftUp:
            addPartWithTextures(trackLeftUpInTexture, texture2: trackLeftUpOutTexture)
        case .RightDown:
            addPartWithTextures(trackRightDownInTexture, texture2: trackRightDownOutTexture)
        case .RightUp:
            addPartWithTextures(trackRightUpInTexture, texture2: trackRightUpOutTexture)
        case .UpDown:
            addPartWithTextures(trackUpDownLeftTexture, texture2: trackUpDownRightTexture)
            
        }
    }
    
    
    func addPartWithTextures(texture1:SKTexture,texture2:SKTexture)
    {
        //let part1Texture = SKTexture(imageNamed:texture1Name)
        //let part2Texture = SKTexture(imageNamed:texture2Name)
        let part1 = SKSpriteNode(texture:texture1)
        let part2 = SKSpriteNode(texture:texture2)
        
        part1.physicsBody = SKPhysicsBody(texture:texture1,size:part1.size)
        part2.physicsBody = SKPhysicsBody(texture:texture2,size:part2.size)
        part1.physicsBody.dynamic = false
        part2.physicsBody.dynamic = false
        
        addChild(part1)
        addChild(part2)
        
        part1.physicsBody.categoryBitMask = 2
        part1.physicsBody.collisionBitMask = 1
        part1.physicsBody.contactTestBitMask = 1
        
        part2.physicsBody.categoryBitMask = 2
        part2.physicsBody.collisionBitMask = 1
        part2.physicsBody.contactTestBitMask = 1
        
        
        
        let background = SKSpriteNode(texture:backgroundTexture)
        background.zPosition = -1
        addChild(background)
        
    }

}
