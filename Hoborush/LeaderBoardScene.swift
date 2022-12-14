//
//  LeaderBoardScene.swift
//  Hoborush
//
//  Created by Ferdinando Carbone on 10/12/22.
//

import SpriteKit
import UIKit


//public var newScores = [salvataggio]()
var playButton = SKSpriteNode(imageNamed: "startGame-export")
var MenuButton = SKSpriteNode(imageNamed: "backtomenuGiusto")
var title = SKSpriteNode(imageNamed: "title1")
var testoPazzo = SKLabelNode(fontNamed: "Emulogic")

class LeaderBoardScene: SKScene {
     init(size: CGSize,score: Int) {
        super.init(size: size)
        let coloriPazzi = [UIColor.systemYellow,UIColor.systemGray,UIColor.systemBrown]
        backgroundColor = .black
        let scores = loadScores()
        let personalScore = SKLabelNode(fontNamed: "Emulogic")
        var scoreHeight = frame.midY
//
        let sceneFrame = CGRect(origin: .zero, size: CGSize(width: 200, height: 200))
        let scene = SKScene(size: sceneFrame.size)
        scene.backgroundColor = UIColor.lightGray

        let textFieldFrame = CGRect(origin: .zero, size: CGSize(width: 200, height: 30))
        let textField = UITextField(frame: textFieldFrame)
        textField.backgroundColor = UIColor.white
        textField.placeholder = "Enter your name here"
        let skView = SKView(frame: sceneFrame)
        skView.addSubview(textField)
        skView.presentScene(scene)
       // self.view.current.liveView = skView
//
        testoPazzo.text = "High Scores"
        title.position = CGPoint(x: frame.midX, y: frame.maxY - 50.0)
        testoPazzo.position = CGPoint(x: title.position.x, y: title.position.y - 1.3*title.size.height)
        for index in scores.indices{
            let rank = "#\(index + 1) \(scores[index].nome): \(scores[index].punti)"
            let scoreNode = SKLabelNode(fontNamed: "Emulogic")
            scoreNode.text = rank
            scoreNode.fontColor = coloriPazzi[index]
            scoreNode.position = CGPoint(x: frame.midX, y: scoreHeight)
            scoreHeight -= scoreNode.fontSize + 25
            addChild(scoreNode)
        }
        playButton.position = CGPoint(x: frame.maxX - 90, y: scoreHeight + 20)
        MenuButton.position = CGPoint(x: frame.midX - 320, y: playButton.position.y)
        playButton.size = CGSize(width: 100, height: 30)
        MenuButton.size = CGSize(width: 80, height: 45)
        self.addChild(playButton)
        self.addChild(MenuButton)
        self.addChild(title)
        self.addChild(testoPazzo)
        personalScore.text = "Your Score:\(score)"
        personalScore.fontColor = .red
        personalScore.fontSize = 20
        personalScore.position = CGPoint(x: frame.width/2,y: scoreHeight + 10)
        self.addChild(personalScore)
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            
            if node == playButton {
                run(SKAction.playSoundFileNamed("suonoBackToMenu.wav", waitForCompletion: true))
                if view != nil {
                    let transition:SKTransition = SKTransition.fade(withDuration: 1)
                    let scene:SKScene = GameScene(size: self.size)
                    self.view?.presentScene(scene, transition: transition)
                }
            }
            else if(node == MenuButton){
                run(SKAction.playSoundFileNamed("suonoBackToMenu.wav", waitForCompletion: true))
                if view != nil {
                    let transition:SKTransition = SKTransition.fade(withDuration: 1)
                    let scene:SKScene = MainMenuScene(size: self.size)
                    self.view?.presentScene(scene, transition: transition)
                }
            }
        }
    }
}
