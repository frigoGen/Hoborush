//
//  GameOverScene.swift
//  Hoborush
//
//  Created by Ferdinando Carbone on 08/12/22.
//

import SpriteKit
import UIKit

public class GameOverScene: SKScene {
    init(size: CGSize, won:Bool) {
    super.init(size: size)
        
    // 1
      backgroundColor = SKColor.gray
    
    // 2
    let message = won ? "You Won!" : "You Lose :["
    var scene: SKScene!
    // 3
    let label = SKLabelNode(fontNamed: "Chalkduster")
    label.text = message
    label.fontSize = 20
    label.fontColor = SKColor.white
        label.position = CGPoint(x: size.width/4, y: size.height - 20)
    addChild(label)
        if(!won){
            let player = SKSpriteNode(imageNamed: "HoboDying1")
            player.size = CGSize(width: 128, height: 128)
            player.position = CGPoint(x: size.width/2, y: size.height/2)
            addChild(player)
            player.run(deathAnimation, withKey: "die")
            print("amDead")
             scene = MainMenuScene(size: size)
        }
        else if(won){
            scene = GameScene(size:size)
        }
    // 4
    run(SKAction.sequence([
      SKAction.wait(forDuration: 3.0),
      SKAction.run() { [weak self] in
        // 5
        guard let `self` = self else { return }
        let reveal = SKTransition.fade(withDuration: 0.5)
        self.view?.presentScene(scene, transition:reveal)
      }
      ]))
   }
  
  // 6
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

