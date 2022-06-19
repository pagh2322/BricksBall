//
//  HomeViewController.swift
//  Bricks Ball
//
//  Created by peo on 2022/06/16.
//

import UIKit
import GameKit

class HomeViewController: UIViewController {
    let homeView: HomeView = {
        return HomeView(frame: UIScreen.main.bounds)
    }()
    
    var gameViewController: GameViewController?
    
    var currentPlayer: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.authenticateUser()
        GKLocalPlayer.local.register(self)

        self.homeView.singleModeButton.addTarget(self, action: #selector(singleModeButtonPressed), for: .touchUpInside)
        self.homeView.multiModeButton.addTarget(self, action: #selector(multiModeButtonPressed), for: .touchUpInside)
    }
    
    override func loadView() {
        super.loadView()
        self.view = self.homeView
        self.view.backgroundColor = .systemBlue
    }

    @objc func singleModeButtonPressed() {
        self.gameViewController = GameViewController(gkMatch: nil)
        self.gameViewController?.modalTransitionStyle = .crossDissolve
        self.gameViewController?.modalPresentationStyle = .fullScreen
        self.present(gameViewController!, animated: true)
    }
    
    @objc func multiModeButtonPressed() {
//        self.presentLeaderboards()
        self.createMatchRequest()
    }
}

// MARK: - Game Center
extension HomeViewController: GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    func authenticateUser() {
        // authenticateHandler will give a view controller we need to present it
        GKLocalPlayer.local.authenticateHandler = { viewController, error in
            if let viewController = viewController {
                // Present the view controller so the player can sign in.
                self.present(viewController, animated: true)
                return
            }
            if error != nil {
                // Player could not be authenticated.
                // Disable Game Center in the game.
                return
            }
            
            // Player was successfully authenticated.
            // Check if there are any player restrictions before starting the game.
            
            if GKLocalPlayer.local.isUnderage {
                // Hide explicit game content.
            }
            
            if GKLocalPlayer.local.isMultiplayerGamingRestricted {
                // Disable multiplayer game features.
            }
            
            if GKLocalPlayer.local.isPersonalizedCommunicationRestricted {
                // Disable in game communication UI.
            }
            
            // Perform any other configurations as needed (for example, access point).
        }
    }
    
    func presentLeaderboards() {
        let vc = GKGameCenterViewController(state: .leaderboards)
        vc.gameCenterDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
}

// MARK: - Multi Feature
extension HomeViewController: GKLocalPlayerListener, GKMatchmakerViewControllerDelegate {
    func matchmakerViewControllerWasCancelled(_ viewController: GKMatchmakerViewController) {
        viewController.dismiss(animated: true)
    }
    
    func matchmakerViewController(
        _ viewController: GKMatchmakerViewController,
        didFailWithError error: Error
    ) {
        
    }
    
    func createMatchRequest() {
        let request = GKMatchRequest()
        request.minPlayers = 1
        request.maxPlayers = 2
        let vc = GKMatchmakerViewController(matchRequest: request)
        vc?.matchmakerDelegate = self
        vc?.matchmakingMode = .default
        self.present(vc!, animated: true)
    }
    
    func player(
        _ player: GKPlayer,
        didAccept invite: GKInvite
    ) {
        let vc = GKMatchmakerViewController(invite: invite)
        vc?.matchmakerDelegate = self
        let rvc = UIApplication.shared.windows.first!.rootViewController
        rvc?.present(vc!, animated: true)
    }
    
    func matchmakerViewController(
        _ viewController: GKMatchmakerViewController,
        didFind match: GKMatch
    ) {
        viewController.dismiss(animated: true)
        self.gameViewController = GameViewController(gkMatch: match)
        match.delegate = self.gameViewController
        self.gameViewController?.modalTransitionStyle = .crossDissolve
        self.gameViewController?.modalPresentationStyle = .fullScreen
        self.present(gameViewController!, animated: true)
    }
}
