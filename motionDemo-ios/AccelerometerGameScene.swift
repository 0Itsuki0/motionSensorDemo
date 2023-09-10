//
//  GameScene.swift
//  motionDemo-ios
//
//  Created by Itsuki on 2023/09/09.
//

import SpriteKit
import GameplayKit
import CoreMotion

class AccelerometerGameScene: SKScene {
    
    private var ball: SKShapeNode!
    private var motionManager: CMMotionManager!
    
    init(sceneSize: CGSize) {
        super.init(size: sceneSize)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sceneDidLoad() {
        setUpBounds()
        createBall()
    }
    
    override func didMove(to view: SKView) {
        
        motionManager = CMMotionManager()
        motionManager.startAccelerometerUpdates()

        self.backgroundColor = SKColor.darkGray
        self.physicsWorld.gravity = .zero
        self.scaleMode = .aspectFit
        

    }
    
    
    private func setUpBounds() {
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = CollisionType.wall.rawValue
    }
    
    
    private func createBall() {
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.02
        let ball = SKShapeNode.init(circleOfRadius: w)
        ball.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        ball.zPosition = 1
        ball.strokeColor = SKColor.green
        ball.physicsBody = SKPhysicsBody(circleOfRadius: w)
        ball.physicsBody?.allowsRotation = false
        ball.physicsBody?.linearDamping = 0.5
        
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.categoryBitMask = CollisionType.object.rawValue
        ball.physicsBody?.collisionBitMask = CollisionType.wall.rawValue
        
        self.ball = ball
        self.addChild(self.ball)
        
    }
    
    

    
    
    override func update(_ currentTime: TimeInterval) {
        print("update acc scene")
        if let accelerometerData = motionManager.accelerometerData {
            physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.x * 7, dy: accelerometerData.acceleration.y * 7)
        }
    }
}
