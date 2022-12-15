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
public var openingGame: SKAction!
public var binAnim: SKAction!
public var shotAnim: SKAction!
public var pistreloAnim : SKAction!
public var pDeadAnima : SKAction!
public var ufoAnim : SKAction!
public var alienoPazzo1 : SKAction!
public var alienoPazzo2 : SKAction!
public var alienoPazzoD : SKAction!

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
    var alienC1Arr: [SKTexture] = []

    for i in 1...7 {
        alienWArr.append(SKTexture(imageNamed: "AlienWalking\(i)"))
        alienC1Arr.append(SKTexture(imageNamed: "AlienoPazzo\(i)"))

    }
    alienWalkingAnimation = SKAction.repeatForever(SKAction.animate(with: alienWArr, timePerFrame: 0.1))
    alienoPazzo1 = SKAction.repeatForever(SKAction.animate(with: alienC1Arr, timePerFrame: 0.1))
}
public func idleAnimation()
{
    var idleArr: [SKTexture] = []
    var shotArr: [SKTexture] = []
    for i in 1...5 {
        idleArr.append(SKTexture(imageNamed: "HoboIdle\(i)"))
        shotArr.append(SKTexture(imageNamed: "HoboShotgun\(i)"))

    }
    idleanimation = SKAction.repeatForever(SKAction.animate(with: idleArr, timePerFrame: 0.15))
    shotAnim = SKAction.animate(with: shotArr, timePerFrame: 0.09)
}
public func HoboAttack(){
    var attArr: [SKTexture] = []
    var pissArr: [SKTexture] = []
    for i in 1...8 {
        pissArr.append(SKTexture(imageNamed: "Pistrelo\(i)"))
        attArr.append(SKTexture(imageNamed: "HoboAttack\(i)"))
    }
    pistreloAnim =  SKAction.repeatForever(SKAction.animate(with: pissArr, timePerFrame: 0.1))
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
        alienDAnimation1 = SKAction.animate(with: alienDArr, timePerFrame: 0.5)
    }
public func AlienSmarmell2(){
    var alienDArr: [SKTexture] = []
        for i in 1...16 {
            alienDArr.append(SKTexture(imageNamed: "AlienDeath2.\(i)"))
        }
        alienDAnimation2 = SKAction.animate(with: alienDArr, timePerFrame: 0.5)
    }
public func AlienSmarmell3(){
    var alienDArr: [SKTexture] = []
        for i in 1...16 {
            alienDArr.append(SKTexture(imageNamed: "AlienDeath3.\(i)"))
        }
        alienDAnimation3 = SKAction.animate(with: alienDArr, timePerFrame: 0.5)
    }
public func introAnim(){
    var introArr: [SKTexture] = []
    var pDeathArr: [SKTexture] = []
    var pDeathArr1: [SKTexture] = []

        for i in 1...9 {
            introArr.append(SKTexture(imageNamed: "Intro\(i)"))
            pDeathArr.append(SKTexture(imageNamed: "pistrelodeath\(i)"))
            pDeathArr1.append(SKTexture(imageNamed: "Alienopazzomorto\(i)"))
        }
    introAnima = SKAction.repeatForever(SKAction.animate(with: introArr, timePerFrame: 0.3))
    pDeadAnima = SKAction.animate(with: pDeathArr, timePerFrame: 0.3)
    alienoPazzoD = SKAction.animate(with: pDeathArr1, timePerFrame: 0.3)
}
public func teamAnim(){
    var teamArr: [SKTexture] = []
        for i in 1...15 {
            teamArr.append(SKTexture(imageNamed: "LogoGamefix\(i)"))
        }
    teamAnima = SKAction.animate(with: teamArr, timePerFrame: 0.35)
        
}
public func GOAnim(){
    var goArr: [SKTexture] = []
    var go1Arr: [SKTexture] = []

        for i in 1...3 {
            goArr.append(SKTexture(imageNamed: "gameover\(i)"))
            go1Arr.append(SKTexture(imageNamed: "AlienoPazzoprimohit\(i)"))

        }
    gameOverAnim = SKAction.repeatForever(SKAction.animate(with: goArr, timePerFrame: 0.45))
    alienoPazzo2 = SKAction.repeatForever(SKAction.animate(with: go1Arr, timePerFrame: 0.45))
}
public func AlienAttAnim(){
    var AAttArr: [SKTexture] = []
        for i in 1...11 {
            AAttArr.append(SKTexture(imageNamed: "alienattack\(i)"))
        }
    alienAttack = SKAction.animate(with: AAttArr, timePerFrame: 0.03)
        
}
public func gameStart() {
    var gameOp: [SKTexture] = []
    for i in 1...13 {
        gameOp.append(SKTexture(imageNamed: "Lights\(i)"))
    }
    openingGame = SKAction.animate(with: gameOp, timePerFrame: 0.08)
}
public func binBuild() {
    var gameOp: [SKTexture] = []
    var ufoArr : [SKTexture] = []
    for i in 1...6 {
        gameOp.append(SKTexture(imageNamed: "firebin\(i)"))
        ufoArr.append(SKTexture(imageNamed: "uforay\(i)"))

    }
    binAnim = SKAction.repeatForever(SKAction.animate(with: gameOp, timePerFrame: 0.15))
    ufoAnim = SKAction.repeatForever(SKAction.animate(with: ufoArr, timePerFrame: 0.15))

    
}

public func AFlyAnim(){
    var pDeathArr: [SKTexture] = []
        for i in 1...9 {
            pDeathArr.append(SKTexture(imageNamed: "pistrelodeath\(i)"))
        }
    pDeadAnima = SKAction.animate(with: pDeathArr, timePerFrame: 0.03)

}
