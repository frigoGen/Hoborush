//
//  animazioni.swift
//  Hoborush
//
//  Created by Ferdinando Carbone on 08/12/22.
//

import SpriteKit

public var deathAnimation : SKAction!
public var attAnimation: SKAction!
public var idleanimation: SKAction!
public var alienWalkingAnimation: SKAction!
public var alienDAnimation1 : SKAction!
public var alienDAnimation2 : SKAction!
public var alienDAnimation3 : SKAction!
public var alienDAnimation : [SKAction] = [alienDAnimation1,alienDAnimation2,alienDAnimation3]
public var gameOverAnim : SKAction!
public var alienAttack : SKAction!

public func deathAn()
{
    var deadArr: [SKTexture] = []
    for i in 1...13 {
        deadArr.append(SKTexture(imageNamed: "HoboDying\(i)"))
    }
    deathAnimation = SKAction.animate(with: deadArr, timePerFrame: 0.1)
}
public func AlienWalkAn()
{
    var alienWArr: [SKTexture] = []
    for i in 1...7 {
        alienWArr.append(SKTexture(imageNamed: "AlienWalking\(i)"))
    }
    alienWalkingAnimation = SKAction.repeatForever(SKAction.animate(with: alienWArr, timePerFrame: 0.1))
}
public func idleAnimation()
{
    var idleArr: [SKTexture] = []
    for i in 1...5 {
        idleArr.append(SKTexture(imageNamed: "HoboIdle\(i)"))
    }
    idleanimation = SKAction.repeatForever(SKAction.animate(with: idleArr, timePerFrame: 0.15))
}
public func HoboAttack(){
    var attArr: [SKTexture] = []
    for i in 1...8 {
        //var scaler = "HoboAttack\(i)"
        //scaler.resize(
        attArr.append(SKTexture(imageNamed: "HoboAttack\(i)"))
    }
    attAnimation = SKAction.animate(with: attArr, timePerFrame: 0.03)
}
public func AlienSmarmell(){
    AlienSmarmell1()
    AlienSmarmell2()
    AlienSmarmell3()
}
public func AlienSmarmell1(){
    var alienDArr: [SKTexture] = []
        for i in 1...16 {
            alienDArr.append(SKTexture(imageNamed: "AlienDeath.\(i)"))
        }
        alienDAnimation1 = SKAction.animate(with: alienDArr, timePerFrame: 0.03)
    }
public func AlienSmarmell2(){
    var alienDArr: [SKTexture] = []
        for i in 1...16 {
            alienDArr.append(SKTexture(imageNamed: "AlienDeath2.\(i)"))
        }
        alienDAnimation2 = SKAction.animate(with: alienDArr, timePerFrame: 0.03)
    }
public func AlienSmarmell3(){
    var alienDArr: [SKTexture] = []
        for i in 1...16 {
            alienDArr.append(SKTexture(imageNamed: "AlienDeath3.\(i)"))
        }
        alienDAnimation3 = SKAction.animate(with: alienDArr, timePerFrame: 0.03)
    }
public func introAnim(){
    var introArr: [SKTexture] = []
        for i in 1...9 {
            introArr.append(SKTexture(imageNamed: "Intro\(i)"))
        }
    introAnima = SKAction.repeatForever(SKAction.animate(with: introArr, timePerFrame: 0.5))
        
}
public func teamAnim(){
    var teamArr: [SKTexture] = []
        for i in 1...15 {
            teamArr.append(SKTexture(imageNamed: "LogoGamefix\(i)"))
        }
    teamAnima = SKAction.animate(with: teamArr, timePerFrame: 0.45)
        
}
public func GOAnim(){
    var goArr: [SKTexture] = []
        for i in 1...3 {
            goArr.append(SKTexture(imageNamed: "gameover\(i)"))
        }
    gameOverAnim = SKAction.repeatForever(SKAction.animate(with: goArr, timePerFrame: 0.45))
        
}
public func AlienAttAnim(){
    var AAttArr: [SKTexture] = []
        for i in 1...11 {
            AAttArr.append(SKTexture(imageNamed: "alienattack\(i)"))
        }
    alienAttack = SKAction.animate(with: AAttArr, timePerFrame: 0.05)
        
}
