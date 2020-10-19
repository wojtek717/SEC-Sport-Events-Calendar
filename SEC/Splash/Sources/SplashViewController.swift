import UIKit
import CommonUI

protocol SplashViewControllerLogic: AnyObject {}

final class SplashViewController: UIViewController {
    // MARK: - Constants
    
    private enum Constants {
        static let gravityMagnitude: CGFloat = 2
        static let tenisBallElasticity: CGFloat = 0.6
        static let scaleFactor: CGFloat = 30
        static let scaleAnimationTime: TimeInterval = 1.5
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet var tenisBall: UIImageView!
    
    // MARK: - Public Properties
    
    var interactor: SplashInteractorLogic?
    var router: SplashRouterType?
    
    // MARK: - Private Properties
    
    private lazy var gravity: UIGravityBehavior! = {
        let gravity = UIGravityBehavior(items: [tenisBall])
        gravity.magnitude = Constants.gravityMagnitude
        
        return gravity
    }()
    private lazy var animator: UIDynamicAnimator! = {
        let animator = UIDynamicAnimator(referenceView: view)
        animator.delegate = self
        
        return animator
    }()
    private lazy var collision: UICollisionBehavior! = {
        UICollisionBehavior(items: [tenisBall])
    }()
    private lazy var tenisBallBehavior: UIDynamicItemBehavior! = {
        let tenisBallBehavior = UIDynamicItemBehavior(items: [tenisBall])
        tenisBallBehavior.elasticity = Constants.tenisBallElasticity
        
        return tenisBallBehavior
    }()
    
    // MARK: - View Methods
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        setup()
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        tenisBall.image = CommonUI.R.image.tenisBall()
        
        let yPosition = ((view.frame.height / 2) + (tenisBall.frame.height / 2))
        
        collision.addBoundary(
            withIdentifier: "midBarier" as NSCopying,
            from: CGPoint(x: 0, y: yPosition),
            to: CGPoint(x: view.frame.width, y: yPosition))
        
        animator.addBehavior(gravity)
        animator.addBehavior(collision)
        animator.addBehavior(tenisBallBehavior)
    }
}

extension SplashViewController: UIDynamicAnimatorDelegate {
    func dynamicAnimatorDidPause(_ animator: UIDynamicAnimator) {
        UIView.animateKeyframes(withDuration: Constants.scaleAnimationTime,
                                delay: 0,
                                options: []) {
            self.tenisBall.transform = CGAffineTransform.identity
                .scaledBy(
                    x: Constants.scaleFactor,
                    y: Constants.scaleFactor)
                .rotated(by: 3/4*CGFloat.pi)
        } completion: { _ in
            self.router?.navigateToNextModule()
        }
        
    }
}

extension SplashViewController: SplashViewControllerLogic {}
