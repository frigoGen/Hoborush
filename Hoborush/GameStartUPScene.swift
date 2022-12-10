//
//  AppStartUP.swift
//  Hoborush
//
//  Created by Ferdinando Carbone on 09/12/22.
//

import SpriteKit
import UIKit

let background1 = SKSpriteNode(imageNamed: "LogoGame1")

class GameStartUPScene: SKScene {
    override init(size: CGSize) {
        super.init(size: size)
        
        background1.position = CGPoint(x: 0.5, y: 0.5)
        addChild(background1)
        background1.run(introAnima, completion:{
            SKAction.wait(forDuration: 1.0)
            SKAction.run() { [weak self] in
                guard let `self` = self else { return }
                let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
                let gameOverScene = GameOverScene(size: self.size, won: false)
                self.view?.presentScene(gameOverScene, transition: reveal)
            }
        })
    }
    required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
}
