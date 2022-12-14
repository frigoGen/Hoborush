//
//  GameScene.swift
//  Hoborush
//
//  Created by Ferdinando Carbone on 06/12/22.
//

import SpriteKit
import GameplayKit
import UIKit

//let backgroundSound = JKAudioPlayer.sharedInstance()
var scoreShower: SKLabelNode!
public var score = 0 {
    didSet {
        scoreShower?.text = "\(score)"
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
    var attendi : Bool = false
    var turn : Bool = false
    var wasHit: Bool = false
    var wasUpHit: Bool = false
    var monstersDestroyed = 0
    var player = SKSpriteNode(imageNamed: "HoboIdle1")
    var background = SKSpriteNode(imageNamed: "Background")
    var backM = SKAudioNode(fileNamed:"backgroundMusic")
    /*var hoboHit = SKAudioNode(fileNamed:"hoboScream1")
    var hoboHit1 = SKAudioNode(fileNamed:"hoboScream2")
    var hitPazzo = SKAudioNode(fileNamed:"crit")*/
    var bin = SKSpriteNode(imageNamed: "firebin1")
    var lightNode = SKSpriteNode(imageNamed: "Lights1")
    var lvlLab = SKLabelNode(fontNamed: "Emulogic")
    var lvlSel : Int = 1
    var precLvl: Int = 1
    var mike : CGFloat = 1.0
    override func didMove(to view: SKView) {
        score = 0
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.size = frame.size
        background.zPosition = 0
        addChild(background)
        lightNode.size = frame.size
        lightNode.zPosition = 3
        lightNode.position = CGPoint(x: frame.midX, y: frame.midY)
        binBuild()
        AFlyAnim()
        GOAnim()
        gameStart()
        AlienAttAnim()
        AlienWalkAn()
        deathAn()
        HoboAttack()
        AlienSmarmell()
        idleAnimation()
        Idle()
        addChild(backM)
        addChild(lightNode)
        backM.autoplayLooped = true
        backM.run(SKAction.play())
        lvlLab.fontSize = 30
        lvlLab.fontColor = .white
        lvlLab.zPosition = 5
        lvlLab.position = CGPoint(x: frame.midX, y: frame.midY)
        //playSound(sound: "backgroundMusic", type: "mp3")
        //backgroundSound.playMusic(fileName: "backgroundMusic.mp3")
        lightNode.run(openingGame,completion: {
            SKAction.wait(forDuration: 5.0)
            self.run(SKAction.repeatForever(
                    SKAction.sequence([
                        SKAction.run(self.addMonster),
                        SKAction.run{ [self] in if (self.precLvl < self.lvlSel){
                            self.lvlLab.text = "Wave \(self.lvlSel)"
                            self.precLvl+=1
                            addChild(lvlLab)
                            self.lightNode.run(openingGame, completion: {
                                self.mike = self.mike*CGFloat(0.75)
                                print("x")
                                SKAction.wait(forDuration: 3.0)
                                self.lvlLab.removeFromParent()
                                self.attendi = true
                               /* self.run(rimuovi, completion: {
                                    SKAction.wait(forDuration: 10)
                                    print("z")})*/
                                
                            })
                        }},
                        SKAction.run{ [self] in if (self.attendi){
                            SKAction.wait(forDuration: 10)
                        }},
                        SKAction.wait(forDuration: self.mike)
                    ])
                ))
        })
        
            
        //HoboAttack()
        //SKAction.removeFromParent()
        //let actionMove = SKAction.run(HoboAttack)
        bin.size = CGSize(width: 128, height: 128)
        bin.zPosition = 1
        bin.position = CGPoint(x: frame.minX + 50, y: player.position.y + 10)
        scoreShower = SKLabelNode(text: "\(score)")
        scoreShower.fontColor = .green
        scoreShower.fontName = "Emulogic"
        scoreShower.fontSize = 20
        scoreShower.position = CGPoint(x: frame.width/2,y: frame.maxY - (1.3*scoreShower.fontSize))
        scoreShower.zPosition = 1
        bin.run(binAnim)
        addChild(bin)
        addChild(scoreShower)
    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
       /*for node in self.children {
          // Check if the node is an SKSpriteNode and if it's in the desired position
            if let spriteNode = node as? SKSpriteNode, spriteNode.position == CGPoint(x:player.position.x + 50,y:player.position.y) {
            // Set the texture of the node to the new texture
                
          }
        }*/
        
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
        run(SKAction.playSoundFileNamed("crit", waitForCompletion: false))
        if(touchRight){
            if(!(player.xScale > 0)){
                player.xScale = player.xScale * -1
            }
        }
        else if(touchLeft){
            if((player.xScale > 0)){
                player.xScale = player.xScale * -1
            }
        }
        player.removeAction(forKey: "animate")
        player.size = CGSize(width: 254, height: 182)
        player.position = CGPoint(x: player.position.x, y: 80 + 30)
        if(turn == false){
            turn = true
            player.run(attAnimation,completion:{
                self.player.position = CGPoint(x: self.size.width/2, y: 80)
                self.player.size = CGSize(width: 128, height: 128)
                self.player.run(idleanimation,withKey: "animate")
                self.turn = false
                
            })
            
        }
        
    }
    func Shoot(){
        
        if(touchRight){
            if(!(player.xScale > 0)){
                player.xScale = player.xScale * -1
            }
        }
        else if(touchLeft){
            if((player.xScale > 0)){
                player.xScale = player.xScale * -1
            }
        }
        player.removeAction(forKey: "animate")
        player.size = CGSize(width: 180, height: 190)
        player.position = CGPoint(x: player.position.x, y: 80)
        if(turn == false){
            turn = true
            player.run(shotAnim,completion:{
                self.run(SKAction.playSoundFileNamed("explosion-03", waitForCompletion: false))
                self.player.position = CGPoint(x: self.size.width/2, y: 80)
                self.player.size = CGSize(width: 128, height: 128)
                self.player.run(idleanimation,withKey: "animate")
                self.turn = false
                
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
        player.position = CGPoint(x: size.width/2, y: 80)
        player.run(idleanimation, withKey: "animate")
        addChild(player)
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
            player.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "HoboShotgun5") , size: player.size)
        player.physicsBody?.isDynamic = true
        player.physicsBody?.categoryBitMask = PhysicsCategory.player
        player.physicsBody?.contactTestBitMask = PhysicsCategory.monster
        player.physicsBody?.collisionBitMask = PhysicsCategory.none
        player.physicsBody?.usesPreciseCollisionDetection = true
    }
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 4294967296)
    }
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    override func touchesBegan(_ touches: Set<UITouch>,with event: UIEvent?){
        for touch in (touches) {
            let location = touch.location(in: self)
            if(location.y < frame.height/2){
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
                
            }
        }
            else if(location.y > frame.height/2){
                if(location.x < size.width/2){
                    touchLeft = true
                    touchRight = false
                    //Attack()
                    Shoot()
                    print("Left")
                } else if(location.x > size.width/2) {
                    touchRight = true
                    touchLeft = false
                    //Attack()
                    Shoot()
                    print("Right")
                    
                }
            }
            /*else {  //x is between -width / 4 and width / 4
                touchMiddle = true
                print("Middle")
            }*/
        }
    }
    func addMonster() {
        
        let whack = random(min: 0.0, max: 1.0)
        var num:CGFloat
        var actualY: CGFloat = 0
        var actualX: CGFloat = 0
        // Create sprite
        var sprites : [SKTexture] = [SKTexture(imageNamed: "AlienWalking1"),SKTexture(imageNamed:"Pistrelo1")]
        let monster = SKSpriteNode()
        monster.texture = sprites.randomElement()
        if monster.texture == sprites[0]{
            actualY = 80
            actualX = frame.width
            monster.size = CGSize(width: 128.0, height: 128.0)
        }
        else if monster.texture == sprites[1]{
            actualY = frame.height
            actualX = frame.width
            monster.size = CGSize(width: 96.0, height: 96.0)
        }
        
        // Determine where to spawn the monster along the Y axis
        //random(min: monster.size.height/2, max: size.height - monster.size.height/2)
        
        if(whack<0.5){
            num = 0
        }
        else{
            num = 1
        }
        // Position the monster slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        monster.zPosition = 3
        monster.position = CGPoint(x: num*actualX, y: actualY)
        if monster.texture == sprites[0]{
            monster.run(alienWalkingAnimation,withKey: "pistrelo")
            
        }
        else if monster.texture == sprites[1]{
            monster.run(pistreloAnim,withKey: "alienWalk")
        }
        
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
        let actualDuration = random(min: CGFloat(3.0), max: CGFloat(5.0))
        // Create the actions
        var alienDir = -1
        if(monster.position.x < size.width){
            alienDir = +1
        }
        let actionMove = SKAction.move(to: CGPoint(x:player.position.x - CGFloat(alienDir*20) ,y: 80),
                                       duration: TimeInterval(actualDuration))
        let actionMoveDone: SKAction = SKAction.removeFromParent()
        /*if ((monster.position.x < player.position.x + 150 && monster.position.x > size.width/2) || (monster.position.x > player.position.x - 150 && monster.position.x < size.width/2 )){
         monster.removeAction(forKey: "alienWalk")
         monster.run(alienAttack,withKey: "alienattack")
         }*/
        let loseAction = SKAction.run() { [weak self] in // // //
            guard let `self` = self else { return }
                let reveal = SKTransition.fade(withDuration: 0.5)
                let gameOverScene = GameOverScene(size: self.size, won: false, incredibile: score)
                self.view?.presentScene(gameOverScene, transition: reveal)
        }
        monster.run(SKAction.sequence([actionMove,loseAction,SKAction.wait(forDuration: 20),actionMoveDone]))

    }
    func baseballBatDidCollideWithMonster(player: SKSpriteNode, monster: SKSpriteNode) {
      print("Hit")
        wasHit = false
        run(SKAction.playSoundFileNamed("deathAlien", waitForCompletion: false))
        monster.physicsBody = nil
        monster.removeAction(forKey: "alienattack")
        if(monster.texture == SKTexture(imageNamed: "AlienWalking1") ){
            monster.run(alienDAnimation.randomElement()!,completion:{
                monster.speed = 0.1
                //self.monsterNoPhysics.texture = SKTexture(imageNamed: "AlienDeath.16")
                print("isDead")
                monster.removeFromParent()
            })}
        else{
            monster.run(pDeadAnima,completion:{
                monster.speed = 0.1
                //self.monsterNoPhysics.texture = SKTexture(imageNamed: "AlienDeath.16")
                print("isDead")
                monster.removeFromParent()
            })
        }
        
        //monsterNoPhysics.removeFromParent()
        monstersDestroyed += 1
        score = monstersDestroyed * 100
        if monstersDestroyed % 20 == 0 {
          lvlSel += 1
        }

    }
    func shotGunHit(player: SKSpriteNode, monster: SKSpriteNode){
        print("UpHit")
          wasUpHit = false
          run(SKAction.playSoundFileNamed("deathAlien", waitForCompletion: false))
          monster.physicsBody = nil
          monster.removeAction(forKey: "pistrelo")
          
          monster.run(pDeadAnima,completion:{
              monster.speed = 0.1
              print("isDead")
              monster.removeFromParent()
          })
          //monsterNoPhysics.removeFromParent()
          monstersDestroyed += 1
          score = monstersDestroyed * 100
          if monstersDestroyed % 20 == 0 {
            lvlSel += 1
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
            
            if(player.size == CGSize(width: 254, height: 182)){
                wasHit = true
            }
            if(monster.size == CGSize(width: 96.0, height: 96.0) ){
                wasUpHit = true
            }
            if monster.texture == SKTexture(imageNamed: "AlienWalking1")
            { monster.removeAction(forKey: "alienWalk")
                monster.run(alienAttack, withKey: "alienattack")
            }
            if(((touchRight == true && monster.position.x > size.width/2) || (touchLeft == true && monster.position.x<size.width/2)) && wasHit == true){
                baseballBatDidCollideWithMonster(player: player, monster: monster)
                if(touchLeft){touchLeft = false}
                else{touchRight = false}
            }
            else if(((touchRight == true && monster.position.x > size.width/2) || (touchLeft == true && monster.position.x<size.width/2)) && wasUpHit == true){
                shotGunHit(player: player, monster: monster)
                if(touchLeft){touchLeft = false}
                else{touchRight = false}
            }

        }
      }
    }

}
