//
//  HomeViewController.swift
//  Bricks Ball
//
//  Created by peo on 2022/06/16.
//

import UIKit
import MultipeerConnectivity

class HomeViewController: UIViewController {
    let homeView: HomeView = {
        return HomeView(frame: UIScreen.main.bounds)
    }()
    
    var gameViewController: GameViewController?
    
    var appDelegate: AppDelegate!
    var currentPlayer: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setAppDelegate()
        self.setObserver()

        self.homeView.singleModeButton.addTarget(self, action: #selector(singleModeButtonPressed), for: .touchUpInside)
    }
    
    override func loadView() {
        super.loadView()
        self.view = self.homeView
        self.view.backgroundColor = .systemBlue
    }
    
    func setAppDelegate() {
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.appDelegate.mpcHandler.setupPeerWithDisplayName(displayName: UIDevice.current.name)
        self.appDelegate.mpcHandler.setupSession()
        self.appDelegate.mpcHandler.advertiseSelf(advertise: true)
    }
    
    func setObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(peerChangedStateWithNotification), name: NSNotification.Name("MPC_DidChangeStateNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleReceiveDataWithNotification), name: NSNotification.Name("MPC_DidReceiveDataNotification"), object: nil)
    }
    
    @objc func peerChangedStateWithNotification(notification: Notification) {
        let userInfo = NSDictionary(dictionary: notification.userInfo!)
        
        let state = userInfo["state"] as? Int
        
        if state != MCSessionState.connecting.rawValue {
            print("Connected")
        }
    }
    
    @objc func handleReceiveDataWithNotification(notification: Notification) {
        
    }
    
    func connectWithPlayer() {
        if self.appDelegate.mpcHandler != nil {
            self.appDelegate.mpcHandler.setupBrowser()
            self.appDelegate.mpcHandler.browser.delegate = self
            
            self.present(appDelegate.mpcHandler.browser, animated: true)
        }
    }

    @objc func singleModeButtonPressed() {
        self.gameViewController = GameViewController()
        self.gameViewController?.modalTransitionStyle = .crossDissolve
        self.gameViewController?.modalPresentationStyle = .fullScreen
        self.present(gameViewController!, animated: true)
//        self.connectWithPlayer()
    }
}

extension HomeViewController: MCBrowserViewControllerDelegate {
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        self.appDelegate.mpcHandler.browser.dismiss(animated: true)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        self.appDelegate.mpcHandler.browser.dismiss(animated: true)
    }
}
