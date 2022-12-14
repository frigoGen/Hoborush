//
//  GameOverScene.swift
//  Hoborush
//
//  Created by Ferdinando Carbone on 08/12/22.
//

import SpriteKit
import UIKit

 
class GameOverScene: SKScene {
    //var pazzo:Int = 0
    var giocatore = salvataggio(nome: "ABC",punti: 0)
    var textField: UITextField!
    var bottone = SKSpriteNode(imageNamed: "enter")
    
    /*override func didMove(to view: SKView) {

            let textFieldFrame = CGRect(origin: CGPoint(x: 50, y: 50), size: CGSize(width: 200, height: 30))
            textField = UITextField(frame: textFieldFrame)
            textField.backgroundColor = SKColor.systemYellow
            textField.placeholder = "Type name"
            view.addSubview(textField)
        }*/
    init(size: CGSize, won:Bool, incredibile: Int) {
        super.init(size: size)
        
    backgroundColor = SKColor.black
    var scene: SKScene!
    // 2
    giocatore = salvataggio(nome: "ABC",punti: incredibile)
    //let message = won ? "You Won!" : "You Lose :["
    // 3
    let gameOverNode = SKSpriteNode(imageNamed: "gameover1")
    /*let label = SKLabelNode(fontNamed: "Chalkduster")
    label.text = message
    label.fontSize = 20
    label.fontColor = SKColor.white
        label.position = CGPoint(x: size.width/4, y: size.height - 20)
    addChild(label)*/
        if(!won){
            let player = SKSpriteNode(imageNamed: "HoboDying1")
            player.size = CGSize(width: 128, height: 128)
            player.position = CGPoint(x: size.width/2, y: size.height/2)
            gameOverNode.position = CGPoint(x: player.position.x, y: player.position.y - 10)
            gameOverNode.size = CGSize(width: frame.width/2 + 320, height: frame.height/2 - 40)
            addChild(player)
            addChild(gameOverNode)
            gameOverNode.run(gameOverAnim, withKey: "gameover")
            player.run(deathAnimation, completion: {
                SKAction.wait(forDuration: 8.0)
                player.removeFromParent()
                SKAction.wait(forDuration: 8.0)
                gameOverNode.removeFromParent()
                let textFieldFrame = CGRect(origin: CGPoint(x: self.frame.minX + 50, y: self.frame.minY + 50), size: CGSize(width: 500, height: 30))
                self.bottone.size = CGSize(width: 150, height: 80)
                self.bottone.position = CGPoint(x: self.frame.maxX - self.bottone.size.width - 10, y: self.frame.maxY - self.bottone.size.height - 25)
                self.textField = UITextField(frame: textFieldFrame)
                self.textField.backgroundColor = SKColor.systemYellow
                self.textField.placeholder = "Enter your Name"
                self.textField.font = UIFont(name: "Emulogic",size: 20)
                self.view?.addSubview(self.textField)
                self.addChild(self.bottone)
                
                
            })
            print("amDead")
            
            
            
            print("HAVEupdated")
            scene = LeaderBoardScene(size: self.size,score: incredibile)
        }
        else if(won){
            scene = GameScene(size:size)
        
        }
    // 4
   }
  
    
  // 6
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       if let touch = touches.first {
           let pos = touch.location(in: self)
           let node = self.atPoint(pos)

           if node == bottone {
               run(SKAction.playSoundFileNamed("suonoStartGame1.wav", waitForCompletion: true))
               self.giocatore.nome = String(self.textField.text!.prefix(3))
               if giocatore.nome == "" {giocatore.nome = "ABC"}
               textField.removeFromSuperview()
               print("NUOVO NOME: \(self.giocatore.nome)")
               updateHighScore(giocatore: giocatore)
               if view != nil {
                   let transition:SKTransition = SKTransition.fade(withDuration: 1)
                   let scene:SKScene = LeaderBoardScene(size: self.size,score: giocatore.punti)
                   self.view?.presentScene(scene, transition: transition)
               }
           }
       }
   }
}

