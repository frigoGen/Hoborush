//
//  GameScene.swift
//  Hoborush
//
//  Created by Ferdinando Carbone on 06/12/22.
//

import SpriteKit
import GameplayKit
import AVFoundation

//let backgroundSound = JKAudioPlayer.sharedInstance()
var scoreShower: SKLabelNode!
public var score = 0 {
    didSet {
    scoreShower.text = "\(score)"
}
}
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
    var monstersDestroyed = 0
    var player = SKSpriteNode(imageNamed: "HoboIdle1")
    var background = SKSpriteNode(imageNamed: "back")
    var backM = SKAudioNode(fileNamed:"backgroundMusic")
    
    override func didMove(to view: SKView) {
        
        background.position = CGPoint(x: size.width, y: size.height)
        background.zPosition = 0
        addChild(background)
        //addChild(backM)
        //let backM = SKAction.playSoundFileNamed("backgroundMusic", waitForCompletion: false)
       // self.run(backM)
        //monsterNoPhysics.size = CGSize(width: 128.0, height: 128.0)
        GOAnim()
        AlienAttAnim()
        AlienWalkAn()
        deathAn()
        HoboAttack()
        AlienSmarmell()
        idleAnimation()
        Idle()
        addChild(backM)
        backM.autoplayLooped = true
        backM.run(SKAction.play())
        //playSound(sound: "backgroundMusic", type: "mp3")
        
        //backgroundSound.playMusic(fileName: "backgroundMusic.mp3")
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(addMonster),
                SKAction.wait(forDuration: 1.0)
            ])
        ))
        //HoboAttack()
        //SKAction.removeFromParent()
        //let actionMove = SKAction.run(HoboAttack)
        scoreShower = SKLabelNode(text: "\(score)")
        scoreShower.fontName = "Emulogic"
        scoreShower.fontSize = 20
        scoreShower.position = CGPoint(x: frame.width/2,y: frame.maxY - (2.0*scoreShower.fontSize))
        scoreShower.zPosition = 1
        addChild(scoreShower)
    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        for node in self.children {
          // Check if the node is an SKSpriteNode and if it's in the desired position
            if let spriteNode = node as? SKSpriteNode, spriteNode.position == CGPoint(x:player.position.x + 100,y:player.position.y) {
            // Set the texture of the node to the new texture
                spriteNode.removeAction(forKey: "alienWalk")
            spriteNode.run(alienAttack, withKey: "alienattack")
          }
        }
        
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
    func MainMenu(){
        SKAction.run() { [weak self] in
            guard let `self` = self else { return }
            let reveal = SKTransition.fade(withDuration: 0.5)
            let gameOverScene = MainMenuScene(size: self.size)
            self.view?.presentScene(gameOverScene, transition: reveal)
        }
    }
    func Idle(){
        player.zPosition = 2
        player.size = CGSize(width: 128, height: 128)
        player.position = CGPoint(x: size.width/2, y: size.height/2)
        player.run(idleanimation, withKey: "animate")
        addChild(player)
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        player.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "HoboAttack4") , size: player.size)
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
        monster.zPosition = 2
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
        var alienDir = -1
        if(monster.position.x < size.width){
            alienDir = +1
        }
        let actionMove = SKAction.move(to: CGPoint(x:player.position.x - CGFloat(alienDir*10) ,y: actualY),
                                       duration: TimeInterval(actualDuration))
        let actionAttack = SKAction.move(to: CGPoint(x:player.position.x ,y: actualY),
                                         duration: TimeInterval(actualDuration))
        let actionMoveDone: SKAction = SKAction.removeFromParent()
        /*if ((monster.position.x < player.position.x + 150 && monster.position.x > size.width/2) || (monster.position.x > player.position.x - 150 && monster.position.x < size.width/2 )){
                          monster.removeAction(forKey: "alienWalk")
                          monster.run(alienAttack,withKey: "alienattack")
                      }*/
        let loseAction = SKAction.run() { [weak self] in
          guard let `self` = self else { return }
            let reveal = SKTransition.fade(withDuration: 0.5)
            let gameOverScene = GameOverScene(size: self.size, won: false, incredibile: score)
          self.view?.presentScene(gameOverScene, transition: reveal)
        }
        monster.run(SKAction.sequence([actionMove,loseAction,SKAction.wait(forDuration: 20),actionMoveDone]))

    }
    func baseballBatDidCollideWithMonster(player: SKSpriteNode, monster: SKSpriteNode) {
      print("Hit")
        //wasHit = true
        //let actionMove = SKAction.
        //monster.run(actionMove)
        monster.physicsBody = nil
        monster.removeAction(forKey: "alienattack")
        //monsterNoPhysics.position = monster.position
        /*monster.run(SKAction.move(to: CGPoint(x: monsterNoPhysics.position.x, y: monsterNoPhysics.position.y),
                                  duration: TimeInterval(0.0)))*/
        //addChild(monsterNoPhysics)
        monster.run(alienDAnimation.randomElement()!,completion:{
            //self.monsterNoPhysics.texture = SKTexture(imageNamed: "AlienDeath.16")
            print("isDead")
            monster.removeFromParent()
        })
        
        //monsterNoPhysics.removeFromParent()
        monstersDestroyed += 1
        score = monstersDestroyed * 100
        /*if monstersDestroyed >= 10 {
          let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
            let gameOverScene = GameOverScene(size: self.size, won: true, incredibile: score)
          view?.presentScene(gameOverScene, transition: reveal)
        }*/ //DECOMMENTA SE VUOI LA VINCITA DEL GIOCO CON LA CONDIZIONE NELL'IF

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
    }

}
