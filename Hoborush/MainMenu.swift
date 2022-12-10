//
//  MainMenu.swift
//  Hoborush
//
//  Created by Ferdinando Carbone on 09/12/22.
//

import SpriteKit
import UIKit


public class MainMenuScene: SKScene {
    let title1 = SKSpriteNode(fileNamed: "title1")
    override init(size: CGSize) {
        super.init(size: size)
        
        
    }
    required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
}




/*let loseAction = SKAction.run() { [weak self] in
 guard let `self` = self else { return }
 let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
   let gameOverScene = GameOverScene(size: self.size, won: false)
 self.view?.presentScene(gameOverScene, transition: reveal)
}*/
