import UIKit

class ViewController: UIViewController {
    
    private lazy var inertialSquare: UIView = {
        var view = UIView()
        view.backgroundColor = .systemBlue
        view.frame = CGRect(x: self.view.center.x - 50, y: self.view.center.y - 50,
                            width: 100, height: 100)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var dynamicAnimator = UIDynamicAnimator()
    private lazy var collision = UICollisionBehavior()
    private var snap: UISnapBehavior?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(inertialSquare)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                          action:
                                                            #selector(didTapped(_:)))
        view.addGestureRecognizer(tapGestureRecognizer)
        
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        collision = UICollisionBehavior(items: [inertialSquare])
        collision.translatesReferenceBoundsIntoBoundary = true
        dynamicAnimator.addBehavior(collision)
    }
    
    @objc func didTapped(_ touch: UITapGestureRecognizer) {
        
        if let snap {
            dynamicAnimator.removeBehavior(snap)
        }
        
        let touchPoint = touch.location(in: view)
        snap = UISnapBehavior(item: inertialSquare, snapTo: touchPoint)
        snap?.damping = 1.1
        dynamicAnimator.addBehavior(snap ?? UISnapBehavior())
    }
}
