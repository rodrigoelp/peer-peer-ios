import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var startHostButton: UIButton!
    @IBOutlet weak var joinHostButton: UIButton!
    @IBOutlet weak var messageText: UITextField!
    @IBOutlet weak var sendMessageButton: UIButton!
    @IBOutlet weak var messagesLog: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messagesLog.text = ""
        messageText.isEnabled = false
        sendMessageButton.isEnabled = false
    }
    
    @IBAction func startHost(_ sender: Any) {
    }
    
    @IBAction func joinHost(_ sender: Any) {
    }
    
    @IBAction func sendMessage(_ sender: Any) {
    }
}
