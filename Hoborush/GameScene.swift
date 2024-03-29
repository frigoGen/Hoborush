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
    static let player: UInt32 = 0b10
    static let projectile: UInt32 = 0b10// 2
}
func +(left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func -(left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func *(point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func /(point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

#if !(arch(x86_64) || arch(arm64))
func sqrt(a: CGFloat) -> CGFloat {
    return CGFloat(sqrtf(Float(a)))
}
#endif

extension CGPoint {
    func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    
    func normalized() -> CGPoint {
        return self / length()
    }
}

class GameScene: SKScene {
    let pauseButton = SKSpriteNode(imageNamed: "pause")
    let resumeButton = SKSpriteNode(imageNamed: "resume")
    var alreadyShot: Bool = false
    var ufo = SKSpriteNode(imageNamed: "uforay1")
    var touchLeft : Bool = false
    var touchRight : Bool = false
    var touchMiddle : Bool = false
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
        scene?.view?.isPaused = false
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
        introAnim()
        gameStart()
        AlienAttAnim()
        AlienWalkAn()
        deathAn()
        HoboAttack()
        AlienSmarmell()
        idleAnimation()
        Idle()
        ufo.size = CGSize(width: 256, height: 128)
        ufo.run(ufoAnim)
        ufo.zPosition = 1
        ufo.position = CGPoint(x: frame.maxX - 40, y: frame.maxY - 115)
        addChild(backM)
        addChild(lightNode)
        addChild(ufo)
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
                            self.mike = self.mike*CGFloat(0.5)
                            print("x")
                            SKAction.wait(forDuration: 3.0)
                            self.lvlLab.removeFromParent()
                            self.attendi = true
                            /* self.run(rimuovi, completion: {
                             SKAction.wait(forDuration: 10)
                             print("z")})*/
                            
                        })
                    }},
                    /*SKAction.run{ [self] in if (self.attendi){
                     SKAction.wait(forDuration: 10)
                     attendi = false
                     }},*/
                    SKAction.wait(forDuration: 1.0)
                ])
            ))
        })
        
        
        //HoboAttack()
        //SKAction.removeFromParent()
        //let actionMove = SKAction.run(HoboAttack)
       // pauseButton.texture = SKTexture(imageNamed: "pause")
        bin.size = CGSize(width: 128, height: 128)
        bin.zPosition = 1
        bin.position = CGPoint(x: frame.minX + 70, y: player.position.y + 10)
        scoreShower = SKLabelNode(text: "\(score)")
        scoreShower.fontColor = .green
        scoreShower.fontName = "Emulogic"
        scoreShower.fontSize = 20
        scoreShower.position = CGPoint(x: frame.width/2,y: frame.maxY - (1.3*scoreShower.fontSize))
        scoreShower.zPosition = 1
        pauseButton.position = CGPoint(x: frame.midX, y: frame.minY + 30)
        pauseButton.zPosition = 4
        pauseButton.size = CGSize(width: 100, height: 16)
        resumeButton.position = CGPoint(x: frame.midX, y: frame.minY + 30)
        resumeButton.zPosition = 4
        resumeButton.size = CGSize(width: 100, height: 16)
        bin.run(binAnim)
        addChild(pauseButton)
        addChild(bin)
        addChild(scoreShower)
    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
    }
    func Attack(){
        if(turn == false){
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
        if(turn == false && alreadyShot == false){
            self.run(SKAction.playSoundFileNamed("explosion-03", waitForCompletion: false))
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
            
            //wasUpHit = true
            player.removeAction(forKey: "animate")
            player.size = CGSize(width: 180, height: 190)
            player.position = CGPoint(x: player.position.x, y: 80)
            //turn = false
            
            turn = true
            player.run(shotAnim,completion:{
                self.player.position = CGPoint(x: self.size.width/2, y: 80)
                self.player.size = CGSize(width: 128, height: 128)
                self.player.run(idleanimation,withKey: "animate")
                self.turn = false
                
            })
            
        }
         else if(turn == false && alreadyShot == true){
            let lowAmmo = SKLabelNode(fontNamed: "Emulogic")
            lowAmmo.fontSize = 10
             lowAmmo.fontColor = .white
             lowAmmo.position = CGPoint(x: scoreShower.position.x, y: scoreShower.position.y - CGFloat(20))
            lowAmmo.text = "LOW AMMO...WAIT"
            print("Game")
            lowAmmo.zPosition = 4
              addChild(lowAmmo)
             lowAmmo.run(SKAction.sequence([SKAction.wait(forDuration: 1),SKAction.removeFromParent()]))
            
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
        player.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "HoboAttack4") , size: player.size)
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
            let node = self.atPoint(location) //start pause
            if node == pauseButton{
                pauseButton.run(SKAction.removeFromParent() ,completion: {
                    SKAction.wait(forDuration: 2)
                })
                addChild(resumeButton)
                print("gae")
                
                scene?.view?.isPaused = true
            }
             if node == resumeButton {
                 resumeButton.run(SKAction.removeFromParent() ,completion: {
                     SKAction.wait(forDuration: 2)
                 })
                 addChild(pauseButton)

                scene?.view?.isPaused = false
                print("joy")
                
            }   // end pause
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
                    print("Left")
                    // Shoot()
                } else if(location.x > size.width/2) {
                    touchRight = true
                    touchLeft = false
                    // Shoot()
                }
                Shoot()
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
        let sprites : [SKTexture] = [SKTexture(imageNamed: "AlienWalking1"),SKTexture(imageNamed:"Pistrelo1"),SKTexture(imageNamed: "AlienoPazzo1")]
        let monster = SKSpriteNode()
        monster.texture = sprites.randomElement()
        if monster.texture == sprites[0]{
            actualY = 80
            actualX = frame.width
            monster.size = CGSize(width: 128.0, height: 128.0)
            //monster.setValue("false", forKey: "name")
            print("cock1")
        }
        else if monster.texture == sprites[1]{
            actualY = frame.height
            actualX = frame.width
            monster.size = CGSize(width: 96.0, height: 96.0)
           // monster.setValue("false", forKey: "name")
            print("cock2")
        }
        else if monster.texture == sprites[2]{
            actualY = frame.height
            actualX = frame.width
            monster.size = CGSize(width: 132.0, height: 132.0)
            monster.setValue("false", forKey: "name")
            print("cock3")
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
        else if monster.texture == sprites[2]{
            monster.run(alienoPazzo1,withKey: "alienWalk")
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
        monster.physicsBody?.contactTestBitMask = PhysicsCategory.projectile // 4
        monster.physicsBody?.collisionBitMask = PhysicsCategory.none // 5
        // Determine speed of the monster
        let actualDuration = random(min: CGFloat(3.0), max: CGFloat(5.0))
        // Create the actions
        var alienDir = -1
        if(monster.position.x < size.width){
            alienDir = +1
        }
        let actionMove = SKAction.move(to: CGPoint(x:player.position.x - CGFloat(alienDir*10) ,y: 80),
                                       duration: TimeInterval(actualDuration))
        let actionMoveDone: SKAction = SKAction.removeFromParent()
        let loseAction = SKAction.run() { [weak self] in // // //
            guard let `self` = self else { return }
            let reveal = SKTransition.fade(withDuration: 0.5)
            let gameOverScene = GameOverScene(size: self.size, won: false, incredibile: score)
            self.view?.presentScene(gameOverScene, transition: reveal)
        }
        monster.run(SKAction.sequence([actionMove,loseAction,SKAction.wait(forDuration: 10),actionMoveDone]))
        
    }
    func baseballBatDidCollideWithMonster(player: SKSpriteNode, monster: SKSpriteNode) {
        monster.physicsBody = nil
        print("Hit")
        wasHit = false
        run(SKAction.playSoundFileNamed("deathAlien", waitForCompletion: false))
        monster.physicsBody = nil
        monster.removeAction(forKey: "alienattack")
        if(monster.texture == SKTexture(imageNamed: "AlienWalking1") ){
            monster.run(alienDAnimation.randomElement()!,completion:{
                //monster.speed = 0.1
                //self.monsterNoPhysics.texture = SKTexture(imageNamed: "AlienDeath.16")
                print("isDead")
                monster.removeFromParent()
            })}
        else{
            monster.run(pDeadAnima,completion:{
                //monster.speed = 0.1
                //self.monsterNoPhysics.texture = SKTexture(imageNamed: "AlienDeath.16")
                print("isDead")
                monster.removeFromParent()
            })
        }
        if(monster.size == CGSize(width: 132, height: 132) || monster.size == CGSize(width: 96, height: 96)){monstersDestroyed += 2}
        //else if(monster.size == CGSize(width: 96, height: 96)){}
        else{
            monstersDestroyed += 1}
        score = monstersDestroyed * 100
        if monstersDestroyed % 20 == 0 {
            lvlSel += 1
        }
        
    }
    func shotGunHit(projectile: SKSpriteNode, monster: SKSpriteNode){
        print("UpHit")
        projectile.removeFromParent()
        alreadyShot = false
        if monster.size == CGSize(width: 132.0, height: 132.0) && monster.value(forKey: "name") as! String == "true" {
            monster.removeAction(forKey: "alienShot")
            monster.physicsBody = nil
            monster.run(alienoPazzoD,completion:{
                //monster.speed = 0.1
                print("isDead")
                monster.removeFromParent()
                self.monstersDestroyed += 1
                score = self.monstersDestroyed * 100
                if self.monstersDestroyed % 20 == 0 {
                    self.lvlSel += 1
                }
            })
            
        }
        else if monster.size == CGSize(width: 132.0, height: 132.0) && monster.value(forKey: "name") as! String == "false" {
            monster.setValue("true", forKey: "name")
            monster.removeAction(forKey: "alienwalk")
            monster.run(alienoPazzo2,withKey: "alienShot")
            
        }
        run(SKAction.playSoundFileNamed("deathAlien", waitForCompletion: false))
        
        if(monster.size == CGSize(width: 96.0, height: 96.0)){
            monster.removeAction(forKey: "pistrelo")
            monster.physicsBody = nil
            monster.run(pDeadAnima,completion:{
                monster.speed = 0.1
                print("isDead")
                monster.removeFromParent()
                self.monstersDestroyed += 1
                score = score + 50
                if self.monstersDestroyed % 20 == 0 {
                    self.lvlSel += 1
                }
            })}
    }
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            // 1 - Choose one of the touches to work with
            guard let touch = touches.first else {
                return
            }
            let touchLocation = touch.location(in: self)
            
            // 2 - Set up initial location of projectile
            let projectile = SKSpriteNode(imageNamed: "projectile")
            projectile.size = CGSize(width: 24, height: 24)
            projectile.position = player.position
            projectile.zPosition = 3
            projectile.physicsBody = SKPhysicsBody(circleOfRadius: projectile.size.width/2)
            projectile.physicsBody?.isDynamic = true
            projectile.physicsBody?.categoryBitMask = PhysicsCategory.projectile
            projectile.physicsBody?.contactTestBitMask = PhysicsCategory.monster
            projectile.physicsBody?.collisionBitMask = PhysicsCategory.none
            projectile.physicsBody?.usesPreciseCollisionDetection = true
            // 3 - Determine offset of location to projectile
            let offset = touchLocation - projectile.position
            
            // 4 - Bail out if you are shooting down or backwards
            // if offset.x < 0 { return }
            
            // 5 - OK to add now - you've double checked position
            if(touchLocation.y >= frame.midY && alreadyShot == false )
            {addChild(projectile)
                alreadyShot = true
            }
            
            // 6 - Get the direction of where to shoot
            let direction = offset.normalized()
            
            // 7 - Make it shoot far enough to be guaranteed off screen
            let shootAmount = direction * 1000
            
            // 8 - Add the shoot amount to the current position
            let realDest = shootAmount + projectile.position
            
            // 9 - Create the actions
            let actionMove = SKAction.move(to: realDest, duration: 2.0)
            let actionMoveDone = SKAction.removeFromParent()
            let go = SKAction.run{self.alreadyShot = false}
            projectile.run(SKAction.sequence([actionMove, actionMoveDone, go]))
        }
        
    }
    extension GameScene: SKPhysicsContactDelegate {
        func didBegin(_ contact: SKPhysicsContact) {
            // 1
            var firstBody: SKPhysicsBody
            var secondBody: SKPhysicsBody
            var thirdBody : SKPhysicsBody
            //var thirdBody: SKPhysicsBody
            if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask{
                firstBody = contact.bodyA
                secondBody = contact.bodyB
                thirdBody = contact.bodyB
            } else {
                firstBody = contact.bodyB
                secondBody = contact.bodyA
                thirdBody = contact.bodyA
            }
            
            // 2
            if ((firstBody.categoryBitMask & PhysicsCategory.monster != 0) &&
                (secondBody.categoryBitMask & PhysicsCategory.player != 0)) {
                if let monster = firstBody.node as? SKSpriteNode,
                   let player = secondBody.node as? SKSpriteNode{
                    if(player.size == CGSize(width: 254, height: 182)){
                        wasHit = true
                    }
                    /*if(monster.size == CGSize(width: 96.0, height: 96.0) ){
                     wasUpHit = true
                     }*/
                    if (monster.size == CGSize(width: 128.0, height: 128.0))
                    { monster.removeAction(forKey: "alienWalk")
                        monster.run(alienAttack, withKey: "alienattack")
                    }
                    if(((touchRight == true && monster.position.x > size.width/2) || (touchLeft == true && monster.position.x<size.width/2)) && wasHit == true){
                        baseballBatDidCollideWithMonster(player: player, monster: monster)
                        if(touchLeft){touchLeft = false}
                        else{touchRight = false}
                    }
                    /*plelse if(((touchRight == true && monster.position.x > size.width/2) || (touchLeft == true && monster.position.x<size.width/2)) && wasUpHit == true){
                     shotGunHit(projectile: projectile, monster: monster)
                     if(touchLeft){touchLeft = false}
                     else{touchRight = false}
                     }*/
                }
            }
            if ((firstBody.categoryBitMask & PhysicsCategory.monster != 0) &&
                (thirdBody.categoryBitMask & PhysicsCategory.projectile != 0)) {
                if let monster = firstBody.node as? SKSpriteNode,
                   let projectile = thirdBody.node as? SKSpriteNode{
                    if ((monster.size == CGSize(width: 96.0, height: 96.0) || monster.size == CGSize(width: 132.0, height: 132.0)) && projectile.size == CGSize(width: 24, height: 24)){
                        print(projectile.size)
                        shotGunHit(projectile: projectile, monster: monster)
                    }
                }
            }
        }
        
    }
