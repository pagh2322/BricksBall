//
//  GameView.swift
//  Bricks Ball
//
//  Created by peo on 2022/06/16.
//

import UIKit
import SpriteKit

class GameView: UIView {
    let gameView: SKView = {
        return SKView()
    }()
    
    func makeSubviews() {
        self.addSubview(self.gameView)
    }
    
    func makeConstraints() {
        self.gameView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.gameView.topAnchor.constraint(equalTo: self.topAnchor),
            self.gameView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.gameView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.gameView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.makeSubviews()
        self.makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
