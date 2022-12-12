//
//  MainMenu.swift
//  Hoborush
//
//  Created by Ferdinando Carbone on 09/12/22.
//


import SpriteKit

class MainMenuScene: SKScene {
    var playButton = SKSpriteNode(imageNamed: "startGame-export")
    var leaderButton = SKSpriteNode(imageNamed: "leaderboard")
    //let playButtonTex = SKTexture(imageNamed: "startGame-export")
    var title = SKSpriteNode(imageNamed: "title1")
    
    //var back
     override func didMove(to view: SKView) {
        title.position = CGPoint(x: frame.midX, y: frame.maxY-title.size.height)
        playButton.position = CGPoint(x: frame.midX, y: frame.minY+playButton.size.height/2)
        playButton.size = CGSize(width: 150, height: 40)
         leaderButton.position = CGPoint(x: playButton.position.x, y: playButton.position.y - leaderButton.size.height/2)
        self.addChild(playButton)
         self.addChild(leaderButton)
        self.addChild(title)
    }

     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
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
            if node == leaderButton {
                if let view = view {
                    let transition:SKTransition = SKTransition.fade(withDuration: 1)
                    let scene:SKScene = LeaderBoardScene(size: self.size)
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
