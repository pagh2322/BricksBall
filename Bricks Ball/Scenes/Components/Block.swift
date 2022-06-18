//
//  Block.swift
//  Bricks Ball
//
//  Created by peo on 2022/06/17.
//

import SpriteKit

class Block: SKShapeNode {
    
    var size: CGSize
    
    private var hp: Int
    
    static var blockList: [Block] = []
    static var blockIndex = 0
    
    override init() {
        self.size = Const.Node.Block.size
        self.hp = 1
        super.init()
        self.name = String(Block.blockIndex)
        self.fillColor = .systemRed
        self.strokeColor = .systemRed
        self.setPhysicsBody()
        self.setBitMask()
    }
    
    convenience init(hp: Int) {
        self.init()
        self.init(rectOf: self.size)
        self.hp = hp
        Block.blockIndex += 1
        Block.blockList.append(self)
    }
    
    
    func setPhysicsBody() {
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.friction = 0.0
        self.physicsBody?.restitution = 1.0
    }
    
    func setBitMask() {
        self.physicsBody?.categoryBitMask = 0x2
        self.physicsBody?.contactTestBitMask = 0x1 | 0x8 // contact with Ball and DetectLine
    }
    
    func reduceHP() {
        if self.hp > 0 {
            self.hp -= 1
        }
    }
    
    func getTouched() {
        self.reduceHP()
        if self.hp == 0 {
            self.removeFromParent()
            Block.blockList.remove(at: Block.blockList.firstIndex(of: self)!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
