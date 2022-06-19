//
//  Ball.swift
//  Bricks Ball
//
//  Created by peo on 2022/06/17.
//

import SpriteKit

class Ball: SKShapeNode {
    override init() {
        super.init()
        self.setColor()
        self.setPhysics()
        self.setBitMask()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setColor() {
        self.fillColor = .systemBlue
    }
    
    func setPhysics() {
        self.physicsBody = SKPhysicsBody(circleOfRadius: Const.Node.Ball.radius)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.friction = 0.0
        self.physicsBody?.restitution = 1.0
        self.physicsBody?.linearDamping = 0.0
    }
    
    func setBitMask() {
        self.physicsBody?.categoryBitMask = 0x1
        self.physicsBody?.contactTestBitMask = 0x2 | 0x4 // contact with DetectLine and Block
        self.physicsBody?.collisionBitMask = 0x2 | 0x4
    }
}
