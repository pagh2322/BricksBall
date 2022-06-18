//
//  DetectLine.swift
//  Bricks Ball
//
//  Created by peo on 2022/06/17.
//

import SpriteKit

class DetectLine: SKShapeNode {
    private let sceneFrame: CGRect
    
    private var startPoint: CGPoint {
        CGPoint(x: 0, y: 0)
    }
    
    private var endPoint: CGPoint {
        CGPoint(x: self.sceneFrame.width, y: 0)
    }
    
    init(sceneFrame frame: CGRect) {
        self.sceneFrame = frame
        
        super.init()
        
        let linePath = UIBezierPath()
        linePath.move(to: self.startPoint)
        linePath.addLine(to: self.endPoint)
        let pattern: [CGFloat] = [10.0, 10.0]
        let dashed = linePath.cgPath.copy(dashingWithPhase: 1, lengths: pattern)
        self.path = dashed
        
        self.strokeColor = .clear
        self.setPhysicsBody()
        self.disableBitMask()
    }
    
    func setPhysicsBody() {
        self.physicsBody = SKPhysicsBody(edgeFrom: self.startPoint, to: self.endPoint)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.restitution = 0.0
        self.physicsBody?.friction = 1.0
    }
    
    func setBitMask() {
        self.physicsBody?.categoryBitMask = 0x4
        self.physicsBody?.contactTestBitMask = 0x1 | 0x2 // contact with Ball and Block
    }
    
    func disableBitMask() {
        self.physicsBody?.categoryBitMask = 0x8
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
