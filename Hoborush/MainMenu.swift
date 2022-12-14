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
    var eggButton = SKShapeNode(circleOfRadius: 25)
    var title = SKSpriteNode(imageNamed: "title1")
    var eggVar = 2
    //var back
     override func didMove(to view: SKView) {
        title.position = CGPoint(x: frame.midX, y: frame.maxY-title.size.height)
        playButton.position = CGPoint(x: frame.midX, y: frame.minY+playButton.size.height/2)
        playButton.size = CGSize(width: 150, height: 40)
         leaderButton.size = playButton.size
         leaderButton.position = CGPoint(x: playButton.position.x, y: playButton.position.y - leaderButton.size.height - 15)
         eggButton.position = CGPoint(x: frame.minX + 70, y: frame.maxY - 50)
         eggButton.fillColor = .darkGray
         //eggButton.alpha = 0.2
         eggButton.run(SKAction.fadeOut(withDuration: 0.9 ))
        self.addChild(playButton)
         self.addChild(leaderButton)
        self.addChild(title)
         self.addChild(eggButton)
    }

     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)

            if node == playButton {
                run(SKAction.playSoundFileNamed("suonoStartGame1.wav", waitForCompletion: true))
                if view != nil {
                    let transition:SKTransition = SKTransition.fade(withDuration: 1)
                    let scene:SKScene = GameScene(size: self.size)
                    self.view?.presentScene(scene, transition: transition)
                }
            }
            if node == eggButton {
                run(SKAction.playSoundFileNamed("suonoBackToMenu.wav", waitForCompletion: true))
                print("pazzi")
                eggVar -= 1
            }
            if eggVar == 0 {
                
                run(SKAction.playSoundFileNamed("suonoBackToMenu.wav", waitForCompletion: true))
                if view != nil {
                    let transition:SKTransition = SKTransition.crossFade(withDuration: 1)
                    let scene:SKScene = eggScene(size: self.size)
                    self.view?.presentScene(scene, transition: transition)
                }
            }
            if node == leaderButton {
                run(SKAction.playSoundFileNamed("suonoBackToMenu.wav", waitForCompletion: true))
                if view != nil {
                    let transition:SKTransition = SKTransition.fade(withDuration: 1)
                    let scene:SKScene = LeaderBoardScene(size: self.size,score:score)
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
