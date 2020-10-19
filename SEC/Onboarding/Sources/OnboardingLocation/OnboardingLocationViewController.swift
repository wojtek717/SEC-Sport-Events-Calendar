import UIKit
import CommonUI

protocol OnboardingLocationViewControllerLogic: AnyObject {}

final class OnboardingLocationViewController: UIViewController {

    // MARK: - IBOulets

    @IBOutlet private var mapBackground: UIImageView!
    @IBOutlet private var locationPin1: UIImageView!
    @IBOutlet private var locationPin2: UIImageView!
    @IBOutlet private var locationPin3: UIImageView!
    
    @IBOutlet private var tenisBall: UIImageView!
    @IBOutlet private var basketBall: UIImageView!
    @IBOutlet private var running: UIImageView!
    
    // MARK: - Public Properties
    
    var interactor: OnboardingLocationInteractorLogic?
    var router: OnboardingLocationRouterType?
    
    // MARK: - View Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 1.0,
                       delay: 2.0,
                       options: []) {
            self.locationPin1.alpha = 0
            self.locationPin2.alpha = 0
            self.locationPin3.alpha = 0
            
            self.tenisBall.alpha = 1
            self.basketBall.alpha = 1
            self.running.alpha = 1
            
            self.tenisBall.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.basketBall.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.running.transform = CGAffineTransform(scaleX: 1, y: 1)
            
        } completion: { (_) in
            
        }
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        self.navigationController?.isNavigationBarHidden = true
        
        mapBackground.image = CommonUI.R.image.mapBackground()
        
        tenisBall.image = CommonUI.R.image.tenisBall()
        basketBall.image = CommonUI.R.image.basketball()
        running.image = CommonUI.R.image.running()
        
        locationPin1.image = CommonUI.R.image.locationPin()
        locationPin2.image = CommonUI.R.image.locationPin()
        locationPin3.image = CommonUI.R.image.locationPin()
        
        tenisBall.transform = CGAffineTransform(scaleX: 0, y: 0)
        basketBall.transform = CGAffineTransform(scaleX: 0, y: 0)
        running.transform = CGAffineTransform(scaleX: 0, y: 0)
    }
}

extension OnboardingLocationViewController: OnboardingLocationViewControllerLogic {}
