//
//  GameViewController.swift
//  Bricks Ball
//
//  Created by peo on 2022/06/16.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    var scene: GameScene?
    let gameView: GameView = {
        return GameView(frame: .zero)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setGameScene()
        self.setGameView()
    }
    
    override func loadView() {
        super.loadView()
        self.view = self.gameView
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    func setGameScene() {
        self.scene = GameScene(size: Const.Scene.gameSceneSize)
        self.scene?.gameViewController = self
        self.scene?.scaleMode = .aspectFit
    }
    func setGameView() {
        self.gameView.gameView.ignoresSiblingOrder = true
        self.gameView.gameView.presentScene(self.scene)
        self.gameView.gameView.showsPhysics = true
        
        self.gameView.topToolBar.settingButton.addTarget(self, action: #selector(settingButtonPressed), for: .touchUpInside)
    }
    
    @objc func settingButtonPressed() {
        print("present setting view / go back alert")
    }
    
    func addToScore(_ score: Int) {
        self.gameView.topToolBar.setCurrentScore(score)
    }
}
