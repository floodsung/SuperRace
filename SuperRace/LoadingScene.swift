//
//  LoadingScene.swift
//  SuperRace
//
//  Created by FloodSurge on 6/19/14.
//  Copyright (c) 2014 FloodSurge. All rights reserved.
//

import SpriteKit

class LoadingScene:SKScene {
    
    init(size: CGSize)
    {
        super.init(size: size)
        backgroundColor = UIColor.blackColor()
        
        let iconTexture = SKTexture(imageNamed:"carIcon")
        let icon = SKSpriteNode(texture:iconTexture)
        icon.position = CGPointMake(size.width/2, size.height/2)
        addChild(icon)
        
        let loadingLabel = SKLabelNode(fontNamed: "Marker Felt")
        loadingLabel.text = "Loading....."
        //loadingLabel.fontColor = UIColor.blackColor()
        loadingLabel.position = CGPointMake(size.width/2, size.height/2 - 80)
        addChild(loadingLabel)
        
        
    }
    
    override func didMoveToView(view: SKView!)
    {
        
        let tranScene = SKAction.runBlock(){() in
            let fade = SKTransition.fadeWithDuration(1.0)
            let gameScene = GameScene.unarchiveFromFile("GameScene") as? GameScene
            self.view.presentScene(gameScene, transition: fade)
            
        }
        let wait = SKAction.waitForDuration(0.3)
        runAction(SKAction.sequence([wait,tranScene]))
        
    }
    
    override func update(currentTime: NSTimeInterval)
    {
        
    }
    
}
