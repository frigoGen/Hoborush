//
//  MainMenu.swift
//  Hoborush
//
//  Created by Ferdinando Carbone on 09/12/22.
//

import SpriteKit


public class MainMenuScene: SKScene {
    var playButton = SKSpriteNode()
    let playButtonTex = SKTexture(imageNamed: "startGame-export")
    var title = SKSpriteNode(imageNamed: "title1")
    var back
    public override func didMove(to view: SKView) {

        playButton = SKSpriteNode(texture: playButtonTex)
        title.position = CGPoint(x: frame.midX, y: frame.maxY-title.size.height)
        playButton.position = CGPoint(x: frame.midX, y: frame.minY+playButton.size.height/2)
        playButton.size = CGSize(width: 150, height: 40)
        self.addChild(playButton)
        self.addChild(title)
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)

            if node == playButton {
                if let view = view {
                    let transition:SKTransition = SKTransition.fade(withDuration: 1)
                    let scene:SKScene = GameScene(size: self.size)
                    self.view?.presentScene(scene, transition: transition)
                }
            }
        }
    }
}




/*let loseAction = SKAction.run() { [weak self] in
 guard let `self` = self else { return }
 let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
   let gameOverScene = GameOverScene(size: self.size, won: false)
 self.view?.presentScene(gameOverScene, transition: reveal)
}*/
