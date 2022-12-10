//
//  GameViewController.swift
//  Hoborush
//
//  Created by Ferdinando Carbone on 06/12/22.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        let scene2 = GameStartUPScene(size: view.bounds.size)
        //let scene1 = GameStartUPScene(size: view.bounds.size)
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        //scene1.scaleMode = .resizeFill
        scene2.scaleMode = .resizeFill
        skView.presentScene(scene2)
    }

}
