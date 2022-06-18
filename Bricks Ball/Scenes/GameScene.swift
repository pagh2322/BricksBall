//
//  GameScene.swift
//  Bricks Ball
//
//  Created by peo on 2022/06/16.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    private var detectLine: DetectLine?
    private var ball = Ball(circleOfRadius: 15)
    private var newBlock: Block?
    
    private var currentBallPosition: CGPoint?
    
    private var canTouch = true
    
    override func didMove(to view: SKView) {
        self.initialize()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.canTouch {
            Block.blockList.forEach { block in
                block.physicsBody?.isDynamic = false
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.canTouch {
            if let touch = touches.first {
                self.canTouch = false
                
                let touchLocation = touch.location(in: self)
                
                let originDX = touchLocation.x - self.currentBallPosition!.x
                var originDY = touchLocation.y - self.currentBallPosition!.y
                
                if originDY < 35 {
                    originDY = 35
                }
                
                var newDX = sqrt(pow(originDX, 2) / (pow(originDX, 2) + pow(originDY, 2))) * 22.0
                let newDY = sqrt(pow(originDY, 2) / (pow(originDX, 2) + pow(originDY, 2))) * 22.0
                
                if originDX < 0 {
                    newDX = 0 - newDX
                }
                
                let impulse = CGVector(dx: newDX, dy: newDY)
                self.ball.physicsBody?.applyImpulse(impulse)
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                    self.detectLine?.setBitMask()
                }
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {

    }
}

// MARK: - Initialize
extension GameScene {
    func initialize() {
        self.setBackground()
        self.setPhysics()
        self.initBall()
        self.initPosition()
        self.initBlocks()
        self.initDetectLine()
    }
    
    func setBackground() {
        self.backgroundColor = .white
    }
    
    func setPhysics() {
        self.scene?.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.scene?.physicsBody?.friction = 0.0
        self.scene?.physicsBody?.restitution = 1.0
        self.scene?.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
    }
    
    func initBall() {
        self.ball.position = Const.Node.Ball.startPosition
        self.addChild(self.ball)
    }
    
    func initPosition() {
        self.currentBallPosition = self.ball.position
    }
    
    func initBlocks() {
        let randomHP = Int.random(in: 2...5)
        self.newBlock = Block(hp: randomHP)
        let randomRowIndex = Int.random(in: 0...1)
        let randomColumnIndex = Int.random(in: 0...6)
//        self.newBlock?.position = Const.Node.Block.possibleStartPositions[randomRowIndex][randomColumnIndex]
        self.newBlock?.setPosition(Const.Node.Block.possibleStartPositions[randomRowIndex][randomColumnIndex])
        self.addChild(self.newBlock!)
        self.addChild(self.newBlock!.hpLabel)
    }
    
    func initDetectLine() {
        self.detectLine = DetectLine(sceneFrame: self.frame)
        self.addChild(self.detectLine!)
    }
}

extension GameScene {
    func makeNextBlock() {
        let randomHP = Int.random(in: 3...6)
        self.newBlock = Block(hp: randomHP)
        let randomColumnIndex = Int.random(in: 0...6)
//        self.newBlock?.position = Const.Node.Block.nextBlockStartPosition[randomColumnIndex]
        self.newBlock?.setPosition(Const.Node.Block.nextBlockStartPosition[randomColumnIndex])
        self.addChild(self.newBlock!)
        self.addChild(self.newBlock!.hpLabel)
    }
    func moveBlocks() {
        Block.blockList.forEach { block in
            block.run(SKAction.moveTo(y: block.position.y - block.size.height, duration: 0.5))
            block.hpLabel.run(SKAction.moveTo(y: block.hpLabel.position.y - block.size.height, duration: 0.5))
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                block.physicsBody?.isDynamic = true
            }
        }
    }
}

// MARK: - Contact
extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        // Ball and Block - Reduce Block's HP
        if (contact.bodyA.categoryBitMask == 0x1 && contact.bodyB.categoryBitMask == 0x2) ||
           (contact.bodyA.categoryBitMask == 0x2 && contact.bodyB.categoryBitMask == 0x1) {
            if contact.bodyA.node is Block {
                Block.blockList.first { block in
                    block.name == contact.bodyA.node?.name
                }?.getTouched()
            } else {
                Block.blockList.first { block in
                    block.name == contact.bodyB.node?.name
                }?.getTouched()
            }
        } else if (contact.bodyA.categoryBitMask == 0x1 && contact.bodyB.categoryBitMask == 0x4) ||
                  (contact.bodyA.categoryBitMask == 0x4 && contact.bodyB.categoryBitMask == 0x1) {
            // Ball and DetectLine - Stop Ball, Next Turn
            self.detectLine?.disableBitMask()
            self.ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            
            self.currentBallPosition = self.ball.position
            
            self.ball.run(SKAction.moveTo(y: 0, duration: 0.0))
            
            self.makeNextBlock()
            self.moveBlocks()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7) {
                self.canTouch = true
            }
        } else if (contact.bodyA.categoryBitMask == 0x2 && contact.bodyB.categoryBitMask == 0x8) ||
                  (contact.bodyA.categoryBitMask == 0x8 && contact.bodyB.categoryBitMask == 0x2) {
            // Block and DetectLine - Game Over
            print("Game Over")
        }
    }
}
