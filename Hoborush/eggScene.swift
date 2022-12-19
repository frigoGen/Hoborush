//
//  eggScene.swift
//  Hoborush
//
//  Created by Ferdinando Carbone on 13/12/22.
//

//
//  LeaderBoardScene.swift
//  Hoborush
//
//  Created by Ferdinando Carbone on 10/12/22.
//

import SpriteKit
import UIKit



class eggScene: SKScene {
    var wow: [SKTexture] = []
    let Button = SKSpriteNode(imageNamed: "backtomenuGiusto")
    let egg = SKSpriteNode(imageNamed: "egg1")
    
    override init(size: CGSize) {
        super.init(size: size)
        
        for i in 1...8 {
            wow.append(SKTexture(imageNamed: "egg\(i)"))
        }
        //let wow: [SKTexture] = ["egg","devs","protoA","protoMon","protoTit","table","protoAlV","usMil"]
        egg.texture = wow.randomElement()
        //let coloriPazzi = [UIColor.systemTeal,UIColor.systemCyan,UIColor.systemMint]
       // backgroundColor = coloriPazzi.randomElement()!
        egg.position = CGPoint(x: frame.midX,y: frame.midY + 20)
        egg.setScale(1/2)
        Button.size = CGSize(width: 80, height: 45)
        Button.position = CGPoint(x: egg.position.x,y: frame.minY + Button.size.height)
       addChild(Button)
        addChild(egg)
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            
            if(node == Button){
                run(SKAction.playSoundFileNamed("suonoBackToMenu.wav", waitForCompletion: true))
                if view != nil {
                    let transition:SKTransition = SKTransition.fade(withDuration: 1)
                    let scene:SKScene = MainMenuScene(size: self.size)
                    self.view?.presentScene(scene, transition: transition)
                }
            }
        }
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

