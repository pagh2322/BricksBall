//
//  GameViewController.swift
//  Bricks Ball
//
//  Created by peo on 2022/06/16.
//

import UIKit
import SpriteKit
import GameplayKit
import GameKit

class GameViewController: UIViewController {
    var scene: GameScene?
    let gameView: GameView = {
        return GameView(frame: .zero)
    }()
    
    private var gkMatch: GKMatch?
    
    init(gkMatch: GKMatch?) {
        self.gkMatch = gkMatch
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        let alertController = UIAlertController(title: "Do you want to go to main?", message: "", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Yes", style: .default) { _ in
            self.dismiss(animated: true)
        }
        let cancelAction = UIAlertAction(title: "No", style: .cancel)
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
    
    func addToScore(_ score: Int) {
        self.gameView.topToolBar.setCurrentScore(score)
        if self.gkMatch != nil {
            self.sendMessage(content: String(score))
        }
    }
}

// MARK: - Multi Feature
extension GameViewController: GKMatchDelegate {
    func match(
        _ match: GKMatch,
        player: GKPlayer,
        didChange state: GKPlayerConnectionState
    ) {
        print("Available player slots: \(String(match.expectedPlayerCount))")
        
        switch state {
        case .connected:
            print("connected")
        case .disconnected:
            print("disconnected")
        default:
            print("default")
        }
    }
    
    func match(
        _ match: GKMatch,
        shouldReinviteDisconnectedPlayer player: GKPlayer
    ) -> Bool {
        true
    }
    
    func sendMessage(content: String) {
        do {
            let data: Data? = content.data(using: .utf8)
            try gkMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.unreliable)
        } catch {
            return
        }
    }
    
    func match(
        _ match: GKMatch,
        didReceive data: Data,
        fromRemotePlayer player: GKPlayer
    ) {
//        let content = String(decoding: data, as: UTF8.self)
        
    }
}
