import UIKit
import MultipeerConnectivity

class ViewController: UIViewController, MCSessionDelegate, MCBrowserViewControllerDelegate {
    private let serviceType = "peer-txtmsg"
    
    @IBOutlet weak var startHostButton: UIButton!
    @IBOutlet weak var joinHostButton: UIButton!
    @IBOutlet weak var messageText: UITextField!
    @IBOutlet weak var sendMessageButton: UIButton!
    @IBOutlet weak var messagesLog: UITextView!
    
    var peerId: MCPeerID!
    var session: MCSession!
    var advertiser: MCAdvertiserAssistant?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInitialUIState()
        
        prepareSession()
    }
    
    @IBAction func startHost(_ sender: Any) {
        advertiser?.stop() // just in case you have started one before.
        
        advertiser = MCAdvertiserAssistant(serviceType: serviceType, discoveryInfo: .none, session: session)
        advertiser?.start()
    }
    
    @IBAction func joinHost(_ sender: Any) {
        advertiser?.stop() // just in case you started a host and now want to join a session.

        let browser = MCBrowserViewController(serviceType: serviceType, session: session)
        browser.delegate = self
        present(browser, animated: true)
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
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
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
