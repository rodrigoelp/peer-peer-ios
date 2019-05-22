import UIKit
import MultipeerConnectivity

class ViewController: UIViewController, MCSessionDelegate {
    @IBOutlet weak var startHostButton: UIButton!
    @IBOutlet weak var joinHostButton: UIButton!
    @IBOutlet weak var messageText: UITextField!
    @IBOutlet weak var sendMessageButton: UIButton!
    @IBOutlet weak var messagesLog: UITextView!
    
    var peerId: MCPeerID!
    var session: MCSession!
    var advertiser: MCAdvertiserAssistant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInitialUIState()
        
        prepareSession()
    }
    
    @IBAction func startHost(_ sender: Any) {
    }
    
    @IBAction func joinHost(_ sender: Any) {
    }
    
    @IBAction func sendMessage(_ sender: Any) {
    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
    }
    
    private func setInitialUIState() {
        messagesLog.text = ""
        messageText.isEnabled = false
        sendMessageButton.isEnabled = false
    }
    
    private func prepareSession() {
        // let's create our identity in the peer network.
        peerId = MCPeerID(displayName: "📨 \(UIDevice.current.name)")
        // then we prepare a session to be used and listen to events.
        session = MCSession(peer: peerId, securityIdentity: .none, encryptionPreference: .required)
        session.delegate = self
    }
}
