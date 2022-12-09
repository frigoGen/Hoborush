//
//  GameScene.swift
//  Hoborush
//
//  Created by Ferdinando Carbone on 06/12/22.
//

import SpriteKit
import GameplayKit

public var deathAnimation : SKAction!
public var attAnimation: SKAction!
public var idleanimation: SKAction!
public var alienWalkingAnimation: SKAction!
public var alienDAnimation : SKAction!

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
    var wasHit: Bool = false
    var monsterNoPhysics = SKSpriteNode(imageNamed: "AlienDeath.1")
    var monstersDestroyed = 0
    //let label = SKLabelNode(text: "Hello SpriteKit!")
    var player = SKSpriteNode(imageNamed: "HoboIdle1")
    var background = SKSpriteNode(imageNamed: "back")
    override func didMove(to view: SKView) {
        background.position = CGPoint(x: size.width, y: size.height)
        // addChild(background)
        monsterNoPhysics.size = CGSize(width: 128.0, height: 128.0)
        idleAnimation()
        AlienWalkAn()
        deathAn()
        HoboAttack()
        Idle()
        AlienSmarmell()
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
    /*func alienDie(monster: SKNode){
        /*if(monster.position.x < size.width/2){
                monster.xScale = player.xScale * -1
            }
            //turn = false
        }
        else if(touchLeft){
            turn = true
            if((player.xScale > 0)){
                player.xScale = player.xScale * -1
            }
        }*/
        print("yes")
    monster.removeAction(forKey: "alienWalk")
    monster.run(alienDAnimation,completion:{
        //self.player.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        //self.player.size = CGSize(width: 128, height: 128)
        monster.run(alienWalkingAnimation,withKey: "alienWalk")
    })
    }*/
    func Attack(){
        if(touchRight){
            turn = false
            if(!(player.xScale > 0)){
                player.xScale = player.xScale * -1
            }
            //turn = false
        }
        else if(touchLeft){
            turn = true
            if((player.xScale > 0)){
                player.xScale = player.xScale * -1
            }
        }
    player.removeAction(forKey: "animate")
    player.size = CGSize(width: 254, height: 182)
    player.position = CGPoint(x: self.size.width/2, y: self.size.height/2 + 30)
        if(wasHit == false){
            wasHit = true
            player.run(attAnimation,completion:{
            self.player.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
            self.player.size = CGSize(width: 128, height: 128)
            self.player.run(idleanimation,withKey: "animate")
            self.wasHit = false
        })
        }
    }
   public func Die(){
    player.removeAction(forKey: "animate")
    player.run(deathAnimation,completion:{
        //self.player.run(idleanimation,withKey: "animate")
        SKAction.wait(forDuration: 3.0)
    })
    }
    func Idle(){
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
        player.physicsBody?.usesPreciseCollisionDetection = false
    }
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    override func touchesBegan(_ touches: Set<UITouch>,with event: UIEvent?){
        for touch in (touches) {
            let location = touch.location(in: self)

            if(location.x < size.width/2){
                touchLeft = true
                touchRight = false
                Attack()
                print("Left")
            } else if(location.x > size.width/2) {
                touchRight = true
                touchLeft = false
                Attack()
                print("Right")
            } /*else {  //x is between -width / 4 and width / 4
                touchMiddle = true
                print("Middle")
            }*/
        }
    }
    func addMonster() {
        let actionMoveDone: SKAction
        let whack = random(min: 0.0, max: 1.0)
        var num:CGFloat
        // Create sprite
        let monster = SKSpriteNode(imageNamed: "AlienWalking1")
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
        monster.run(alienWalkingAnimation,withKey: "alienWalk")
        if(!(monster.position.x > 0)){
            monster.xScale = monster.xScale * -1
        }
        // Add the monster to the scene
        addChild(monster)
        monster.physicsBody = SKPhysicsBody(rectangleOf: monster.size) // 1
        monster.physicsBody?.isDynamic = true // 2
        monster.physicsBody?.categoryBitMask = PhysicsCategory.monster // 3
        monster.physicsBody?.contactTestBitMask = PhysicsCategory.player // 4
        monster.physicsBody?.collisionBitMask = PhysicsCategory.none // 5
        // Determine speed of the monster
       /* monster.physicsBody?.velocity = self.physicsBody!.velocity
        if(num == 0){
            monster.physicsBody?.applyImpulse(CGVector(dx: -1 * random(min: 3.0, max: 5.0),dy: 0))
            
        }
        else{
            monster.physicsBody?.applyImpulse(CGVector(dx: random(min: 3.0, max: 5.0),dy: 0))
            
        }*/
        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        
        // Create the actions
        let actionMove = SKAction.move(to: CGPoint(x: size.width/2, y: actualY),
                                       duration: TimeInterval(actualDuration))
            actionMoveDone = SKAction.removeFromParent()
        let loseAction = SKAction.run() { [weak self] in
          guard let `self` = self else { return }
          let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
            let gameOverScene = GameOverScene(size: self.size, won: false)
          self.view?.presentScene(gameOverScene, transition: reveal)
        }
        monster.run(SKAction.sequence([actionMove,loseAction,actionMoveDone]))

    }
    func baseballBatDidCollideWithMonster(player: SKSpriteNode, monster: SKSpriteNode) {
      print("Hit")
        //wasHit = true
        //let actionMove = SKAction.
        //monster.run(actionMove)
        monster.removeAction(forKey: "alienWalk")
        //monsterNoPhysics.position = monster.position
        
        /*monster.run(SKAction.move(to: CGPoint(x: monsterNoPhysics.position.x, y: monsterNoPhysics.position.y),
                                  duration: TimeInterval(0.0)))*/
        //addChild(monsterNoPhysics)
        monster.run(alienDAnimation,completion:{
            //self.monsterNoPhysics.texture = SKTexture(imageNamed: "AlienDeath.16")
            print("isDead")
            monster.removeFromParent()
        })
        
        //monsterNoPhysics.removeFromParent()
        monstersDestroyed += 1
        if monstersDestroyed >= 10 {
          let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
            let gameOverScene = GameOverScene(size: self.size, won: true)
          view?.presentScene(gameOverScene, transition: reveal)
        }

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
          let player = secondBody.node as? SKSpriteNode {
            if((touchRight == true && monster.position.x > size.width/2) || (touchLeft == true && monster.position.x<size.width/2)){
                baseballBatDidCollideWithMonster(player: player, monster: monster)
                if(touchLeft){touchLeft = false}
                else{touchRight = false}
            }
        }
      }
        
        let player = firstBody.node
        let monster = secondBody.node
    }

}
