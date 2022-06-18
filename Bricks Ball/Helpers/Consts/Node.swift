//
//  Node.swift
//  Bricks Ball
//
//  Created by peo on 2022/06/17.
//

import Foundation
import UIKit

extension Const {
    struct Node {
        struct DetectLine {
            
        }
        
        struct Ball {
            static let radius = 15.0
            static let startPosition = CGPoint(x: Scene.gameSceneWidth / 2.0, y: 0)
        }
        
        struct Block {
            static let size = CGSize(width: Scene.gameSceneWidth / 7.0, height: Scene.gameSceneHeight / 15) // 1 row, 7 blocks; 1 column, 15 blocks
            static let hpLabelFontSize = size.height - 20.0
            static let possibleStartPositions = [
                [
                    CGPoint(
                        x: size.width / 2.0,
                        y: Scene.gameSceneHeight - size.height / 2.0
                    ),
                    CGPoint(
                        x: size.width / 2.0 + size.width,
                        y: Scene.gameSceneHeight - size.height / 2.0
                    ),
                    CGPoint(
                        x: size.width / 2.0 + size.width * 2,
                        y: Scene.gameSceneHeight - size.height / 2.0
                    ),
                    CGPoint(
                        x: size.width / 2.0 + size.width * 3,
                        y: Scene.gameSceneHeight - size.height / 2.0
                    ),
                    CGPoint(
                        x: size.width / 2.0 + size.width * 4,
                        y: Scene.gameSceneHeight - size.height / 2.0
                    ),
                    CGPoint(
                        x: size.width / 2.0 + size.width * 5,
                        y: Scene.gameSceneHeight - size.height / 2.0
                    ),
                    CGPoint(
                        x: size.width / 2.0 + size.width * 6,
                        y: Scene.gameSceneHeight - size.height / 2.0
                    ),
                ],
                [
                    CGPoint(
                        x: size.width / 2.0,
                        y: Scene.gameSceneHeight - size.height / 2.0 - size.height
                    ),
                    CGPoint(
                        x: size.width / 2.0 + size.width,
                        y: Scene.gameSceneHeight - size.height / 2.0 - size.height
                    ),
                    CGPoint(
                        x: size.width / 2.0 + size.width * 2,
                        y: Scene.gameSceneHeight - size.height / 2.0 - size.height
                    ),
                    CGPoint(
                        x: size.width / 2.0 + size.width * 3,
                        y: Scene.gameSceneHeight - size.height / 2.0 - size.height
                    ),
                    CGPoint(
                        x: size.width / 2.0 + size.width * 4,
                        y: Scene.gameSceneHeight - size.height / 2.0 - size.height
                    ),
                    CGPoint(
                        x: size.width / 2.0 + size.width * 5,
                        y: Scene.gameSceneHeight - size.height / 2.0 - size.height
                    ),
                    CGPoint(
                        x: size.width / 2.0 + size.width * 6,
                        y: Scene.gameSceneHeight - size.height / 2.0 - size.height
                    )
                ]
            ]
            static let nextBlockStartPosition = [
                CGPoint(
                    x: size.width / 2.0,
                    y: Scene.gameSceneHeight + size.height / 2.0
                ),
                CGPoint(
                    x: size.width / 2.0 + size.width,
                    y: Scene.gameSceneHeight + size.height / 2.0
                ),
                CGPoint(
                    x: size.width / 2.0 + size.width * 2,
                    y: Scene.gameSceneHeight + size.height / 2.0
                ),
                CGPoint(
                    x: size.width / 2.0 + size.width * 3,
                    y: Scene.gameSceneHeight + size.height / 2.0
                ),
                CGPoint(
                    x: size.width / 2.0 + size.width * 4,
                    y: Scene.gameSceneHeight + size.height / 2.0
                ),
                CGPoint(
                    x: size.width / 2.0 + size.width * 5,
                    y: Scene.gameSceneHeight + size.height / 2.0
                ),
                CGPoint(
                    x: size.width / 2.0 + size.width * 6,
                    y: Scene.gameSceneHeight + size.height / 2.0
                )
            ]
        }
    }
}
