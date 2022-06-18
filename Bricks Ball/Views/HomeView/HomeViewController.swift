//
//  HomeViewController.swift
//  Bricks Ball
//
//  Created by peo on 2022/06/16.
//

import UIKit

class HomeViewController: UIViewController {
    let homeView: HomeView = {
        return HomeView(frame: UIScreen.main.bounds)
    }()
    
    var gameViewController: GameViewController?
    
    var currentPlayer: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.homeView.singleModeButton.addTarget(self, action: #selector(singleModeButtonPressed), for: .touchUpInside)
    }
    
    override func loadView() {
        super.loadView()
        self.view = self.homeView
        self.view.backgroundColor = .systemBlue
    }

    @objc func singleModeButtonPressed() {
        self.gameViewController = GameViewController()
        self.gameViewController?.modalTransitionStyle = .crossDissolve
        self.gameViewController?.modalPresentationStyle = .fullScreen
        self.present(gameViewController!, animated: true)
    }
}
