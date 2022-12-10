//
//  LeaderBoardScene.swift
//  Hoborush
//
//  Created by Ferdinando Carbone on 10/12/22.
//

import SpriteKit

class LeaderBoardScene: SKScene {
    init(size: CGSize, pescatore: salvataggio) {
        super.init(size: size)
        
        var playButton = SKSpriteNode(imageNamed: "startGame-export")
        var MenuButton = SKSpriteNode(imageNamed: "startGame-export")
        var title = SKSpriteNode(imageNamed: "title1")
        //var back
         func didMove(to view: SKView) {
            let scores = loadScores()
            print("CRASH")
            let personalScore = SKLabelNode(fontNamed: "Emulogic")
            var scoreHeight = frame.maxY - playButton.size.height/2
            //playButton = SKSpriteNode(texture: playButtonTex)
            title.position = CGPoint(x: frame.midX, y: frame.maxY-title.size.height)
            playButton.position = CGPoint(x: frame.maxX-playButton.size.width/2, y: frame.minY+playButton.size.height/2)
            playButton.size = CGSize(width: 40, height: 10)
            MenuButton.position = CGPoint(x: playButton.position.x, y: playButton.position.y + 10 + MenuButton.size.height/2)
            MenuButton.size = CGSize(width: 40, height: 10)
            for index in scores.indices{
                let rank = "\(index + 1) \(scores[index].name): \(scores[index].value)"
                let scoreNode = SKLabelNode(fontNamed: "Emulogic")
                scoreNode.text = "High Scores"
                scoreNode.fontColor = .white
                scoreNode.position = CGPoint(x: 125, y: scoreHeight)
                scoreHeight -= 20
                addChild(scoreNode)
            }
            self.addChild(playButton)
            self.addChild(MenuButton)
            self.addChild(title)
            personalScore.text = "\(score)"
            personalScore.fontColor = .yellow
            personalScore.position = CGPoint(x: frame.width/2,y:frame.width/2)
        }
        
         func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
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
                else if(node == MenuButton){
                    if let view = view {
                        let transition:SKTransition = SKTransition.fade(withDuration: 1)
                        let scene:SKScene = MainMenuScene(size: self.size)
                        self.view?.presentScene(scene, transition: transition)
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
    }
    required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
}
