//
//  PlayerNameScene.swift
//  Hoborush
//
//  Created by Ferdinando Carbone on 14/12/22.
//
/*import UIKit
import SpriteKit

class PlayerName: SKScene {
        var textField: UITextField!
        
            
          
        
         init(size: CGSize, incredibile: Int) {
            
            super.init(size: size)
            
            let btnAlert = SKLabelNode(text: "Enter")
            btnAlert.name = "btn_text"
            btnAlert.fontSize = 20
            btnAlert.fontColor = SKColor.systemGreen
            btnAlert.fontName = "Emulogic"
            btnAlert.position = CGPoint(x: size.width / 2, y: size.height / 2)
            addChild(btnAlert)
            
            //        let textFieldFrame = CGRect(origin: CGPoint(x: 50, y: 50), size: CGSize(width: 200, height: 30))
            //        textField = UITextField(frame: textFieldFrame)
            //        textField.backgroundColor = SKColor.systemYellow
            //        textField.placeholder = "Type name"
            //
            //        view?.addSubview(textField)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
            
        }
        
        func showTextField() {
            
            let textFieldFrame = CGRect(origin: CGPoint(x: 50, y: 100), size: CGSize(width: 200, height: 30))
            let textField = UITextField(frame: textFieldFrame)
            textField.backgroundColor = SKColor.systemRed
            textField.placeholder = "Type name"
            
            
            view?.addSubview(textField)
            
        }
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            
            if let touch = touches.first {
                let location = touch.location(in: self)
                let action = atPoint(location)
                
                if action.name == "btn_text" {
                    showTextField()
                }
            }
        }
}
*/
