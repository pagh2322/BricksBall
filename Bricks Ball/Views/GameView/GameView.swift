//
//  GameView.swift
//  Bricks Ball
//
//  Created by peo on 2022/06/16.
//

import UIKit
import SpriteKit

class GameView: UIView {
    let topToolBar: TopToolBar = {
        return TopToolBar(frame: .zero)
    }()
    let gameView: SKView = {
        return SKView(frame: .zero)
    }()
    let bottomToolBar: BottomToolBar = {
        return BottomToolBar(frame: .zero)
    }()
    
    func makeSubviews() {
        self.addSubview(self.topToolBar)
        self.addSubview(self.gameView)
        self.addSubview(self.bottomToolBar)
    }
    
    func makeConstraints() {
        self.topToolBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topToolBar.topAnchor.constraint(equalTo: self.topAnchor),
            self.topToolBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.topToolBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.topToolBar.widthAnchor.constraint(equalToConstant: Const.View.TopToolBar.width),
            self.topToolBar.heightAnchor.constraint(equalToConstant: Const.View.TopToolBar.height)
        ])
        
        self.gameView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.gameView.topAnchor.constraint(equalTo: self.topToolBar.bottomAnchor),
            self.gameView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.gameView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.gameView.bottomAnchor.constraint(equalTo: self.bottomToolBar.topAnchor)
        ])
        
        self.bottomToolBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.bottomToolBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.bottomToolBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.bottomToolBar.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.bottomToolBar.topAnchor.constraint(equalTo: self.gameView.bottomAnchor),
            self.bottomToolBar.widthAnchor.constraint(equalToConstant: Const.View.BottomToolBar.width),
            self.bottomToolBar.heightAnchor.constraint(equalToConstant: Const.View.BottomToolBar.height)
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
