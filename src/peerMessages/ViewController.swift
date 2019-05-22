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
    
    var msgStorage = [Message]()
    
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
        guard let message = messageText.text, !message.isEmpty else {
            return
        }
        let msg = TextMessage(outgoing: message)
        store(msg)
        post(msg)
        updateMessages()
    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        enableMessageControls(session.connectedPeers.count > 0)
        
        let msg: Message?
        switch state {
        case .connecting:
            msg = SystemMessage(description: "\(peerId.displayName) has joined!")
        case .notConnected:
            msg = SystemMessage(description: "\(peerId.displayName) has logged out!")
        default:
            msg = nil
            print("Peer is connected...")
        }
        
        guard let message = msg else { return }
        store(message)
        updateMessages()
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        guard let incoming = String(bytes: data, encoding: .utf8) else { return }
        let message = TextMessage(incoming: incoming)
        store(message)
        updateMessages()
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
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    
    private func setInitialUIState() {
        messagesLog.text = ""
        enableMessageControls(false)
    }
    
    private func enableMessageControls(_ enabled: Bool = true) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.messageText.isEnabled = enabled
            self.sendMessageButton.isEnabled = enabled
        }
    }
    
    private func prepareSession() {
        // let's create our identity in the peer network.
        peerId = MCPeerID(displayName: "📨 \(UIDevice.current.name)")
        // then we prepare a session to be used and listen to events.
        session = MCSession(peer: peerId, securityIdentity: .none, encryptionPreference: .required)
        session.delegate = self
    }
    
    private func store(_ msg: Message) {
        msgStorage.append(msg)
    }
    
    private func updateMessages() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.messagesLog.text = self.msgStorage.map({ $0.description }).joined(separator: "\n\n")
        }
    }
    
    private func post(_ msg: TextMessage) {
        guard let data = msg.content.data(using: .utf8), session.connectedPeers.count > 0 else { return }
        
        do { try session.send(data, toPeers: session.connectedPeers, with: .reliable) }
        catch let e as NSError {
            // needs to display the error... will display it later as an alert of sorts.
            print("ERROR: \(e.localizedDescription)")
        }
    }
}
