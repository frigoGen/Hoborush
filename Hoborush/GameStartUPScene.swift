//
//  GameStartUPScene.swift
//  Hoborush
//
//  Created by Ferdinando Carbone on 10/12/22.
//

import SpriteKit
import UIKit

public var introAnima: SKAction!
public var teamAnima: SKAction!
class GameStartUPScene: SKScene {

        var Backbone = SKSpriteNode(imageNamed: "Intro1")
        var creatividad = SKSpriteNode(imageNamed: "LogoGamefix1")
        override func didMove(to view: SKView) {
            introAnim()
            teamAnim()
            let transition:SKTransition = SKTransition.fade(withDuration: 3.0)
            let scene:SKScene = MainMenuScene(size: self.size)
            //label.position = CGPoint(x: 100,y: 33)
            Backbone.position = CGPoint(x: size.width/2, y: size.height/2)
            Backbone.size = CGSize(width: size.width, height: size.height)
            Backbone.zPosition = 1
            creatividad.zPosition = 2
            creatividad.position = CGPoint(x: size.width/2, y: size.height/2 )
            creatividad.size = CGSize(width: size.width/2, height: size.height/2)
            //addChild(label)
            addChild(Backbone)
            addChild(creatividad)
            Backbone.run(introAnima)
            creatividad.run(teamAnima,completion: {
                //wait(forDuration: 2000.0)
                print("wowwww")
                //self.creatividad.removeFromParent()
                self.view!.presentScene(scene, transition: transition)
            })
            //Backbone.removeFromParent()
            
            
            
            //playButton = SKSpriteNode(texture: playButtonTex)
            //label.size = CGSize(width: 128,height: 128)
        }
        /*override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
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
        }*/
    }

