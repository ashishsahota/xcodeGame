//
//  GameOverScene.swift
//  7 Sides
//
//  Created by Ashish Sahota on 2017-06-10.
//  Copyright © 2017 Ashish Sahota. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene:SKScene{
    override func didMove(to view: SKView) {
        let scoreLabel:SKLabelNode = self.childNode(withName: "scoreLabel") as! SKLabelNode
        scoreLabel.text = "SCORE:\(score)"
        
        let highScoreLabel:SKLabelNode = self.childNode(withName: "highScoreLabel") as! SKLabelNode
        let highScore = UserDefaults.standard.integer(forKey: "highScoreSaved")
        highScoreLabel.text = "HIGH SCORE:\(highScore)"
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let sceneToMoveTo = GameScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let sceneTransition = SKTransition.fade(withDuration: 0.5)
        self.view!.presentScene(sceneToMoveTo, transition: sceneTransition)
        
        
        
    }
    
}
