//
//  GameScene.swift
//  Hoborush
//
//  Created by Ferdinando Carbone on 06/12/22.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    //let label = SKLabelNode(text: "Hello SpriteKit!")
    let player = SKSpriteNode(imageNamed: "hobo2")
    var background = SKSpriteNode(imageNamed: "back")
    /*@objc func tap(recognizer: UIGestureRecognizer) {
     let viewLocation = recognizer.location(in: view)
     let sceneLocation = convertPoint(fromView: viewLocation)
     let moveToAction = SKAction.move(to: sceneLocation, duration: 1)
     label.run(moveToAction)
     }*/
    override func didMove(to view: SKView) {
        background.position = CGPoint(x: size.width, y: size.height)
        // 3
        player.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        // 4
        
        addChild(player)
        run(SKAction.repeatForever(
              SKAction.sequence([
                SKAction.run(addMonster),
                SKAction.wait(forDuration: 1.0)
                ])
            ))
        addChild(background)
        

        
    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    func addMonster() {
        let whack = random(min: 0.0, max: 1.0)
        var num:CGFloat = 1
        // Create sprite
        let monster = SKSpriteNode(imageNamed: "Stick")
        monster.size = CGSize(width: 128.0, height: 128.0)
        // Determine where to spawn the monster along the Y axis
        let actualY = monster.size.height/2 //random(min: monster.size.height/2, max: size.height - monster.size.height/2)
        if(whack<0.5){
            num = 0
        }
        else{
            num = 1
        }
        // Position the monster slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        monster.position = CGPoint(x: num*(size.width), y: actualY)
        
        // Add the monster to the scene
        addChild(monster)
        
        // Determine speed of the monster
        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        
        // Create the actions
        let actionMove = SKAction.move(to: CGPoint(x: size.width/2, y: actualY),
                                       duration: TimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        monster.run(SKAction.sequence([actionMove, actionMoveDone]))
    }
    
}
