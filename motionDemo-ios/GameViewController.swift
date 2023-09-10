//
//  GameViewController.swift
//  motionDemo-ios
//
//  Created by Itsuki on 2023/09/09.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    @IBOutlet weak var skView: SKView!
    
    @IBOutlet var modeSelectButtons: [UIButton]!
    
    var selectedModeTag = 0 {
        didSet {
            changeGameScene()
        }
    }
    
    var gyroscopeScene: GyroscopeGameScene!
    var accelerometerScene: AccelerometerGameScene!

    override func viewDidLoad() {
        gyroscopeScene = GyroscopeGameScene(sceneSize: skView.bounds.size)
        accelerometerScene = AccelerometerGameScene(sceneSize: skView.bounds.size)
        
        skView.showsFPS = false
        skView.showsNodeCount = false
        skView.ignoresSiblingOrder = true
        gyroscopeScene.scaleMode = .aspectFit
        skView.presentScene(accelerometerScene)
        
    }
    
    

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func onSelectButtonPressed(_ sender: UIButton) {
        selectedModeTag = sender.tag
        for button in modeSelectButtons {
            if button != sender {
                button.isSelected = false
            } else {
                button.isSelected = true
            }
        }
        
    }
    
    
    
}


extension GameViewController {
    
    private func changeGameScene() {
        switch selectedModeTag {
        case 0:
            skView.presentScene(accelerometerScene)
        case 1:
            skView.presentScene(gyroscopeScene)
        default:
            return
        }
        
    }
    
}
