//
//  GameOverScene.swift
//  Hoborush
//
//  Created by Ferdinando Carbone on 08/12/22.
//

import SpriteKit
import UIKit

private var enteredName: String?
var nameField: UITextField!
class GameOverScene: SKScene {
    init(size: CGSize, won:Bool, incredibile: Int) {
    super.init(size: size)
        
    backgroundColor = SKColor.blue
    
    // 2
    var giocatore = salvataggio(nome: "ABC",punti: incredibile)
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
            updateHighScore(giocatore: giocatore)
            print("HAVEupdated")
            scene = LeaderBoardScene(size: self.size, pescatore: giocatore)
        }
        else if(won){
            scene = GameScene(size:size)
            nameField = UITextField(frame: CGRect(x: 50, y: 50, width: 200, height: 50))
            nameField.placeholder = "Enter your name"
            view?.addSubview(nameField)
            giocatore.nome = "\(enteredName?.prefix(3) ?? "ABC")"
        
        }
    // 4
    run(SKAction.sequence([
      SKAction.wait(forDuration: 3.0),
      SKAction.run() { [weak self] in
        guard let `self` = self else { return }
        let reveal = SKTransition.fade(withDuration: 0.5)
        self.view?.presentScene(scene, transition:reveal)
      }
      ]))
   }
  
    /*func EndGame() -> Void{
        guard nome == readLine() else{ nome = "ABCD"
            return
        }
        updateHighScore(with:(name: nome, value: score))
        LeaderBoardScene().pescatore = (nome,score)
        
    }*/
    @IBAction func saveButtonTapped(_ sender: Any) {
            // Save the text of the UITextField in the enteredName variable
         enteredName = nameField.text
        }
  // 6
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

