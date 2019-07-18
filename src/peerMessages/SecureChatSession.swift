//

import Foundation
import MultipeerConnectivity

class SecureChatSession: NSObject {
    let peerId: MCPeerID
    let session: MCSession
    
    override init() {
        peerId = MCPeerID(displayName: "📨 \(UIDevice.current.name)")
        session = MCSession(peer: peerId, securityIdentity: .none, encryptionPreference: .required)
        super.init()
        session.delegate = self
    }
}

extension SecureChatSession: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        // not going to be using this one.
        assertionFailure("This should not be called.")
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        // not going to be using this one.
        assertionFailure("This should not be called.")
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        // not going to be using this one.
        assertionFailure("This should not be called.")
    }
}
