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
    
    var appDelegate: AppDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        
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
        self.scene?.scaleMode = .aspectFit
//        self.scene?.view?.showsPhysics = true
    }
    func setGameView() {
        self.gameView.gameView.ignoresSiblingOrder = true
        self.gameView.gameView.showsPhysics = true
        self.gameView.gameView.presentScene(self.scene)
    }
}
