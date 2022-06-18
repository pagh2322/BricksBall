//
//  MPCHandler.swift
//  Bricks Ball
//
//  Created by peo on 2022/06/16.
//

import MultipeerConnectivity

class MPCHandler: NSObject {
    var peerID: MCPeerID!
    var session: MCSession!
    var browser: MCBrowserViewController!
    var advertiser: MCAdvertiserAssistant? = nil
    
    func setupPeerWithDisplayName(displayName: String) {
        self.peerID = MCPeerID(displayName: displayName)
    }
    
    func setupSession() {
        self.session = MCSession(peer: self.peerID)
        self.session.delegate = self
    }
    
    func setupBrowser() {
        self.browser = MCBrowserViewController(serviceType: "new-game", session: self.session)
    }
    
    func advertiseSelf(advertise: Bool) {
        if self.advertiser == nil {
            self.advertiser = MCAdvertiserAssistant(serviceType: "new-game", discoveryInfo: nil, session: self.session)
            self.advertiser?.start()
        } else {
            self.advertiser?.stop()
            self.advertiser = nil
        }
    }
}

extension MPCHandler: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        let userInfo: [String: Any] = [
            "peerID": self.peerID,
            "state": state.rawValue
        ]
        
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: NSNotification.Name("MPC_DidChangeStateNotification"), object: nil, userInfo: userInfo)
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        let userInfo: [String: Any] = [
            "data": data,
            "peerId": self.peerID
        ]
        
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: NSNotification.Name("MPC_DidReceiveDataNotification"), object: nil, userInfo: userInfo)
        }
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
}

