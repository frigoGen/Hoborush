//
//  GameViewController.swift
//  Hoborush
//
//  Created by Ferdinando Carbone on 06/12/22.
//

import UIKit
import SpriteKit
import GameplayKit
import GameKit

class GameViewController: UIViewController {
    
    func authenticateLocalPlayer() {
        let localPlayer = GKLocalPlayer.local
        localPlayer.authenticateHandler = {(viewController, error) -> Void in
            
            if (viewController != nil) {
                self.present(viewController!, animated: true, completion: nil)
            }
            else {
                print((GKLocalPlayer.local.isAuthenticated))
            }
        }
    }
    override func viewDidLoad() {
            authenticateLocalPlayer()
            let scene2 = GameScene(size: view.bounds.size)
            let scene1 = GameStartUPScene(size: view.bounds.size)
            let skView = view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            skView.ignoresSiblingOrder = true
            //scene1.scaleMode = .resizeFill
            scene2.scaleMode = .resizeFill
            skView.presentScene(scene2)
        }
}
