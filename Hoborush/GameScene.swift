//
//  GameScene.swift
//  Hoborush
//
//  Created by Ferdinando Carbone on 06/12/22.
//

import SpriteKit
import GameplayKit

struct PhysicsCategory {
  static let none      : UInt32 = 0
  static let all       : UInt32 = UInt32.max
  static let monster   : UInt32 = 0b1       // 1
  static let player: UInt32 = 0b10      // 2
}

class GameScene: SKScene {
    var touchLeft : Bool = false
    var touchRight : Bool = false
    var turn : Bool = false
    //var player : SKSpriteNode!
    var attAnimation: SKAction!
    var idleanimation: SKAction!
    //var player : SKSpriteNode!
    //let label = SKLabelNode(text: "Hello SpriteKit!")
    var player = SKSpriteNode(imageNamed: "HoboIdle1")
    var background = SKSpriteNode(imageNamed: "back")
    /*@objc func tap(recognizer: UIGestureRecognizer) {
     let viewLocation = recognizer.location(in: view)
     let sceneLocation = convertPoint(fromView: viewLocation)
     let moveToAction = SKAction.move(to: sceneLocation, duration: 1)
     label.run(moveToAction)
     }*/
    override func didMove(to view: SKView) {
        background.position = CGPoint(x: size.width, y: size.height)
       // addChild(background)
        idleAnimation()
        run(SKAction.repeatForever(
              SKAction.sequence([
                SKAction.run(addMonster),
                SKAction.wait(forDuration: 1.0)
                ])
            ))
        //HoboAttack()
        //SKAction.removeFromParent()
        //let actionMove = SKAction.run(HoboAttack)

        
    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    func HoboAttack()
    {
        var attArr: [SKTexture] = []
        for i in 1...8 {
            //var scaler = "HoboAttack\(i)"
            //scaler.resize(
            attArr.append(SKTexture(imageNamed: "HoboAttack\(i)"))
        }
        attAnimation = SKAction.animate(with: attArr, timePerFrame: 0.03)
        if(touchRight){
            turn = true
            if(!(player.xScale > 0)){
                player.xScale = player.xScale * -1
            }
            player.removeAction(forKey: "animate")
            player.size = CGSize(width: 254, height: 182)
            self.player.position = CGPoint(x: self.size.width/2, y: self.size.height/2 + 30)
            player.run(attAnimation,completion:{
                self.player.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
                self.player.size = CGSize(width: 128, height: 128)
                self.player.run(self.idleanimation,withKey: "animate")
           })
            turn = false
        }
        else if(touchLeft){
            turn = true
            if((player.xScale > 0)){
                player.xScale = player.xScale * -1
            }
            player.removeAction(forKey: "animate")
            player.size = CGSize(width: 254, height: 182)
            self.player.position = CGPoint(x: self.size.width/2, y: self.size.height/2 + 30)
            player.run(attAnimation,completion:{
                self.player.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
                self.player.size = CGSize(width: 128, height: 128)
                self.player.run(self.idleanimation,withKey: "animate")
           })
            turn = false
        }
    }
    func idleAnimation()
    {
        var idleArr: [SKTexture] = []
        for i in 1...5 {
            idleArr.append(SKTexture(imageNamed: "HoboIdle\(i)"))
        }
        idleanimation = SKAction.repeatForever(SKAction.animate(with: idleArr, timePerFrame: 0.15))
        player.size = CGSize(width: 128, height: 128)
        player.position = CGPoint(x: size.width/2, y: size.height/2)
        player.run(idleanimation, withKey: "animate")
        addChild(player)
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.isDynamic = true
        player.physicsBody?.categoryBitMask = PhysicsCategory.player
        player.physicsBody?.contactTestBitMask = PhysicsCategory.monster
        player.physicsBody?.collisionBitMask = PhysicsCategory.none
        player.physicsBody?.usesPreciseCollisionDetection = true
    }
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    override func touchesBegan(_ touches: Set<UITouch>,with event: UIEvent?){
        //var touchMiddle : Bool = false

        for touch in (touches) {
            let location = touch.location(in: self)

            if(location.x < size.width/2){
                touchLeft = true
                touchRight = false
                HoboAttack()
                print("Left")
            } else if(location.x > size.width/2) {
                touchRight = true
                touchLeft = false
                HoboAttack()
                print("Right")
            } /*else {  //x is between -width / 4 and width / 4
                touchMiddle = true
                print("Middle")
            }*/
        }
    }
    func addMonster() {
        let whack = random(min: 0.0, max: 1.0)
        var num:CGFloat = 1
        // Create sprite
        let monster = SKSpriteNode(imageNamed: "alieno")
        monster.size = CGSize(width: 128.0, height: 128.0)
        // Determine where to spawn the monster along the Y axis
        let actualY = size.height/2 //random(min: monster.size.height/2, max: size.height - monster.size.height/2)
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
        monster.physicsBody = SKPhysicsBody(rectangleOf: monster.size) // 1
        monster.physicsBody?.isDynamic = true // 2
        monster.physicsBody?.categoryBitMask = PhysicsCategory.monster // 3
        monster.physicsBody?.contactTestBitMask = PhysicsCategory.player // 4
        monster.physicsBody?.collisionBitMask = PhysicsCategory.none // 5
        // Determine speed of the monster
        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        
        // Create the actions
        let actionMove = SKAction.move(to: CGPoint(x: size.width/2, y: actualY),
                                       duration: TimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        monster.run(SKAction.sequence([actionMove, actionMoveDone]))
    }
    func baseballBatDidCollideWithMonster(player: SKSpriteNode, monster: SKSpriteNode) {
      print("Hit")
      //projectile.removeFromParent()
      monster.removeFromParent()
    }
}
extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
      // 1
      var firstBody: SKPhysicsBody
      var secondBody: SKPhysicsBody
      if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
        firstBody = contact.bodyA
        secondBody = contact.bodyB
      } else {
        firstBody = contact.bodyB
        secondBody = contact.bodyA
      }
     
      // 2
      if ((firstBody.categoryBitMask & PhysicsCategory.monster != 0) &&
          (secondBody.categoryBitMask & PhysicsCategory.player != 0)) {
        if let monster = firstBody.node as? SKSpriteNode,
          let projectile = secondBody.node as? SKSpriteNode {
            if((touchRight == true && monster.position.x > size.width/2) || (touchLeft == true && monster.position.x<size.width/2)){
                baseballBatDidCollideWithMonster(player: player, monster: monster)
                if(touchLeft){touchLeft = false}
                else{touchRight = false}
            }
        }
      }
    }

}
