//

import UIKit

protocol Coordinator {
    var children: [Coordinator] { get }
    
    func start()
}

protocol CoordinatedViewController: UIViewController {
    var coordinator: Coordinator? { get set }
}

class MainCoordinator: Coordinator {
    let children = [Coordinator]()

    private let window: UIWindow
    private let navigationController: UINavigationController
    private let storyboard: UIStoryboard
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        self.storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: ViewController.self)) as! ViewController
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
