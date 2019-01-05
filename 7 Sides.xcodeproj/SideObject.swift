//
//  SideObject.swift
//  7 Sides
//
//  Created by Ashish Sahota on 2017-04-15.
//  Copyright © 2017 Ashish Sahota. All rights reserved.
//

import Foundation
import SpriteKit

class Side:SKSpriteNode{
    
    let type:colorType
    
    init(type:colorType){
        self.type = type
        
        let sideTexture = SKTexture(imageNamed: "side_\(self.type)")
        
        super.init(texture: sideTexture, color: SKColor.clear, size: sideTexture.size())
        
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody!.affectedByGravity = false
        self.physicsBody!.categoryBitMask = PhysicsCatergories.Side
        self.physicsBody!.collisionBitMask = PhysicsCatergories.None
        self.physicsBody!.contactTestBitMask = PhysicsCatergories.Ball
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
