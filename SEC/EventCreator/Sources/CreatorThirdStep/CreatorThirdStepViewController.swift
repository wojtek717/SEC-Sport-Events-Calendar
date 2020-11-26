import UIKit

protocol CreatorThirdStepViewControllerLogic: AnyObject {}

final class CreatorThirdStepViewController: UIViewController {

    // MARK: - Public Properties

    var interactor: CreatorThirdStepInteractorLogic?
    var router: CreatorThirdStepRouterType?
    
    // MARK: - View Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup()
    }
    
    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "When?"
    }
}

extension CreatorThirdStepViewController: CreatorThirdStepViewControllerLogic {}
