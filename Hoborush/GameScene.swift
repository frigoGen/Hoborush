//
//  GameScene.swift
//  Hoborush
//
//  Created by Ferdinando Carbone on 06/12/22.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var touchLeft : Bool = false
    var touchRight : Bool = false
    var player : SKSpriteNode!
    //var player : SKSpriteNode!
    //let label = SKLabelNode(text: "Hello SpriteKit!")
    //let player = SKSpriteNode(imageNamed: "HoboIdle1")
    var attAnimation:SKAction!
    var idleanimation:SKAction!
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
        
        //addChild(player)
        idleAnimation()
        run(SKAction.repeatForever(
              SKAction.sequence([
                SKAction.run(addMonster),
                SKAction.wait(forDuration: 1.0)
                ])
            ))
        HoboAttack()
        
       // addChild(background)
        //SKAction.removeFromParent()
        //let actionMove = SKAction.run(HoboAttack)

        
    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    func HoboAttack()
    {
        let att1 = SKTexture(imageNamed: "HoboAttack1")
        /*player = SKSpriteNode(texture: att1)
        player.size = CGSize(width: 288, height: 192)
        player.position = CGPoint(x: size.width/2 + 64, y: player.size.height/2)*/
        let att2 = SKTexture(imageNamed: "HoboAttack2")
        let att3 = SKTexture(imageNamed: "HoboAttack3")
        let att4 = SKTexture(imageNamed: "HoboAttack4")
        let att5 = SKTexture(imageNamed: "HoboAttack5")
        let att6 = SKTexture(imageNamed: "HoboAttack6")
        let att7 = SKTexture(imageNamed: "HoboAttack7")
        let att8 = SKTexture(imageNamed: "HoboAttack8")
        
        attAnimation = SKAction.animate(with: [att1, att2, att3, att4, att5,att6,att7,att8], timePerFrame: 0.05)
        if(touchRight){
            player.removeAction(forKey: "animate")
            //addChild(player)
            /*let actionMove = SKAction.repeat(attAnimation, count: 1)
            let actionMoveDone = SKAction.removeFromParent()*/
            //player.run(SKAction.sequence([actionMove, actionMoveDone]))
            player.run(attAnimation,completion:{
                self.player.run(self.idleanimation,withKey: "animate")
           })
            touchRight = false
        }
        else{
            print("TODO")
        }
    }
    func idleAnimation()
    {
        let idle1 = SKTexture(imageNamed: "HoboIdle1")
        //idle = SKSpriteNode(texture: idle1)
        player.size = CGSize(width: 128, height: 128)
        player.position = CGPoint(x: size.width/2, y: player.size.height/2)
        addChild(player)
        
        let idle2 = SKTexture(imageNamed: "HoboIdle2")
        let idle3 = SKTexture(imageNamed: "HoboIdle3")
        let idle4 = SKTexture(imageNamed: "HoboIdle4")
        let idle5 = SKTexture(imageNamed: "HoboIdle5")
        idleanimation = SKAction.repeatForever(SKAction.animate(with: [idle1, idle2, idle3, idle4, idle5], timePerFrame: 0.20))
        
        player.run(idleanimation, withKey: "animate")
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
                print("Left")
            } else {
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
