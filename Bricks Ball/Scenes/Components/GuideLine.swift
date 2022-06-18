//
//  GuideLine.swift
//  Bricks Ball
//
//  Created by peo on 2022/06/18.
//

import SpriteKit

class GuideLine: SKShapeNode {
    private var ballPosition: CGPoint
    
    var endPosition: CGPoint
    
    init(ballPosition position: CGPoint) {
        self.ballPosition = position
        self.endPosition = CGPoint(x: 0, y: 0)
        super.init()
        
        self.strokeColor = .green
    }
    
    
    func setLine(ballPosition: CGPoint, touchPosition: CGPoint) {
        self.ballPosition = ballPosition
        var newEndPositionX = CGFloat(0)
        var newEndPositionY = CGFloat(0)
        var tempTouchPosition = touchPosition
        if tempTouchPosition.y < 35 {
            tempTouchPosition.y = 35
        }
        if tempTouchPosition.x > ballPosition.x {
            newEndPositionX = Const.Scene.gameSceneWidth
            newEndPositionY = tempTouchPosition.y + (tempTouchPosition.y / (tempTouchPosition.x - ballPosition.x)) * (Const.Scene.gameSceneWidth - tempTouchPosition.x)
        } else {
            newEndPositionX = 0
            newEndPositionY = tempTouchPosition.y + (tempTouchPosition.y / (ballPosition.x - touchPosition.x)) * tempTouchPosition.x
        }
        
        self.endPosition = CGPoint(x: newEndPositionX, y: newEndPositionY)
        let linePath = UIBezierPath()
        linePath.move(to: self.ballPosition)
        linePath.addLine(to: self.endPosition)
        let pattern: [CGFloat] = [10.0, 10.0]
        let dashed = linePath.cgPath.copy(dashingWithPhase: 1, lengths: pattern)
        self.path = dashed
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
