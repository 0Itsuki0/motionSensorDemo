//
//  GyroscopeGameScene.swift
//  motionDemo-ios
//
//  Created by Itsuki on 2023/09/10.
//


import SpriteKit
import GameplayKit
import CoreMotion

class GyroscopeGameScene: SKScene {
    private var square: SKShapeNode!
    private var motionManager: CMMotionManager!
    
    init(sceneSize: CGSize) {
        super.init(size: sceneSize)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func sceneDidLoad() {
        setUpBounds()
        createSquare()
    }
    

    
    override func didMove(to view: SKView) {
        
        motionManager = CMMotionManager()
        motionManager.startGyroUpdates()

        self.backgroundColor = SKColor.green
        self.physicsWorld.gravity = .zero
        self.scaleMode = .aspectFit

    }
    
    
    private func setUpBounds() {
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = CollisionType.wall.rawValue
    }
    
    
    private func createSquare() {
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.03
        let square = SKShapeNode.init(rectOf: CGSize(width: w, height: w), cornerRadius: w*0.2)
        square.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        square.zPosition = 1
        square.strokeColor = SKColor.red
        square.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: w, height: w))
        square.physicsBody?.allowsRotation = true
        square.physicsBody?.linearDamping = 0.5
        
        square.physicsBody?.isDynamic = true
        square.physicsBody?.categoryBitMask = CollisionType.object.rawValue
        square.physicsBody?.collisionBitMask = CollisionType.wall.rawValue
        
        self.square = square
        self.addChild(self.square)
        
    }
    
    

    
    
    override func update(_ currentTime: TimeInterval) {
        print("update gyro scene")
        if let gyroData = motionManager.gyroData {
            let rotateAction = SKAction.rotate(byAngle: gyroData.rotationRate.z * 0.1, duration: motionManager.gyroUpdateInterval)
            square.run(rotateAction)

        }

    }
}
