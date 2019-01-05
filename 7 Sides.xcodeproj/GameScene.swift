//
//  GameScene.swift
//  7 Sides
//
//  Created by Ashish Sahota on 2017-04-13.
//  Copyright © 2017 Ashish Sahota. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var colourWheelBase = SKShapeNode()
    
    let spinColorWheel = SKAction.rotate(byAngle: -convertDegreestoRadians(degrees: 360/7), duration: 0.2)
    let playCorrectSound = SKAction.playSoundFileNamed("correctSound.wav", waitForCompletion: false)
    let playIncorrectSound = SKAction.playSoundFileNamed("IncorrectSound.wav", waitForCompletion: false)
    
    var currentGameState: gameState = gameState.beforeGame
    
    let tapToStartLabel = SKLabelNode (fontNamed: "Strange Tales")
    let scoreLabel = SKLabelNode (fontNamed: "Strange Tales")
    let highScoreLabel = SKLabelNode (fontNamed: "Strange Tales")

    var highScore = UserDefaults.standard.integer(forKey: "highScoreSaved")
    
    override func didMove(to view: SKView) {
        score = 0
        ballMovementSpeed = 2
        
        self.physicsWorld.contactDelegate = self
        
        let background = SKSpriteNode(imageNamed: "colourfull")
        background.size = self.size
        background.position = (CGPoint(x: self.size.width/2, y: self.size.height/2))
        background.zPosition = -1
        self.addChild(background)
        
        colourWheelBase = SKShapeNode (rectOf: CGSize(width: self.size.width*0.8, height: self.size.width*0.8))
        colourWheelBase.position = (CGPoint(x: self.size.width/2, y: self.size.height/2))
        colourWheelBase.fillColor = SKColor.clear
        colourWheelBase.strokeColor = SKColor.clear
        self.addChild(colourWheelBase)
        
        prepColourWheel()
        
        tapToStartLabel.text = "TAP TO START"
        tapToStartLabel.fontSize = 130
        tapToStartLabel.fontColor = SKColor.darkGray
        tapToStartLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.1)
        self.addChild(tapToStartLabel)
        
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.9)
        scoreLabel.fontColor = SKColor.darkGray
        scoreLabel.fontSize = 225
        self.addChild(scoreLabel)
        
        highScoreLabel.text = "BEST:\(highScore)"
        highScoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.85)
        highScoreLabel.fontColor = SKColor.darkGray
        highScoreLabel.fontSize = 100
        self.addChild(highScoreLabel)
        
    }
    func prepColourWheel(){
        
        for i in 0...6{
        let side = Side(type: colorWheelOrder[i])
        let basePosition = CGPoint(x: self.size.width/2, y: self.size.height*0.25)
        side.position = convert(basePosition, to: colourWheelBase)
        side.zRotation = -colourWheelBase.zRotation
            
        colourWheelBase.addChild(side)
        colourWheelBase.zRotation += convertDegreestoRadians(degrees: 360/7)
        
        }
        
        for side in colourWheelBase.children{
            
            let sidePostion = side.position
            let postionInScene = convert(sidePostion, from: colourWheelBase)
            sidePositions.append(postionInScene)
            
            
            
        }
        
    }
    
    
    func spawnBall(){
        
     let ball = Ball()
     ball.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
     self.addChild(ball)
        
    }
    func startTheGame (){
        spawnBall()
     
        currentGameState = .inGame
        
        let scaleDown = SKAction.scale(to: 0, duration: 0.2)
        let deleteLabel = SKAction.removeFromParent()
        let deleteSequence = SKAction.sequence([scaleDown, deleteLabel])
        tapToStartLabel.run(deleteSequence)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if currentGameState == .beforeGame {
            //start the game
            startTheGame()
        }
        else if currentGameState == .inGame{
            //spin the color
            colourWheelBase.run(spinColorWheel)
            
        }
        
        
    }
   
    
    func didBegin(_ contact: SKPhysicsContact) {
  
        let ball: Ball
        let side: Side
        if contact.bodyA.categoryBitMask == PhysicsCatergories.Ball{
            ball = contact.bodyA.node! as! Ball
            side = contact.bodyB.node! as! Side
            
        } else{
            ball = contact.bodyB.node! as! Ball
            side = contact.bodyA.node! as! Side
            
        }
        if ball.isActive == true {
        checkMatch(ball: ball, side: side)

        }
    }
    func checkMatch(ball: Ball, side: Side) {
    if ball.type == side.type{
    //correct
        correctMatch(ball: ball)
        print ("Correct!!!")
    } else{
        //incorect
        wrongMatch(ball:ball)
        print ("Incorrect!!!")
        }
    }
   
func correctMatch(ball: Ball){
    ball.delete()
    
    score += 1
    scoreLabel.text = "\(score)"
    
    switch score { //difficluty to hard HOW FAST THE BALL MOVES
    case 5: ballMovementSpeed = 1.8
    case 15: ballMovementSpeed = 1.6
    case 25: ballMovementSpeed = 1.5
    case 40: ballMovementSpeed = 1.4
    case 60: ballMovementSpeed = 1.3
    default: print("")
    }
    
    spawnBall()
    
    if score > highScore{
        highScoreLabel.text = "BEST:\(score)"
    }
    self.run(playCorrectSound)
    
}

    func wrongMatch(ball: Ball){
        //end of the game
        if score > highScore{
        highScore = score
        UserDefaults.standard.set(highScore, forKey: "highScoreSaved")
        }
       ball.flash()
       self.run(playIncorrectSound)
       currentGameState = .afterGame
       colourWheelBase.removeAllActions()
       let waitToChangeScene = SKAction.wait(forDuration: 2.8)
        let changeScene = SKAction.run {
            let sceneToMoveTo = GameOverScene(fileNamed: "GameOverScene")!
            sceneToMoveTo.scaleMode = self.scaleMode
            let sceneTransition = SKTransition.fade(withDuration: 0.5)
            self.view!.presentScene(sceneToMoveTo, transition: sceneTransition)
            
            
        }
        let sceneChangeSequence = SKAction.sequence([waitToChangeScene, changeScene])
        self.run(sceneChangeSequence)
        
    }
    
}






