import Core
import CommonUI
import DesignSystem
import UIKit

protocol SportTypeSelectViewControllerLogic: AnyObject {}

final class SportTypeSelectViewController: UIViewController {

    // MARK: - Public Properties

    var interactor: SportTypeSelectInteractorLogic?
    var router: SportTypeSelectRouterType?
    
    // MARK: - View Methods
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
        
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        
    }
    
    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Sport types"
        
        let quitButton = UIBarButtonItem(
            image: CommonUI.R.image.close(),
            style: .plain,
            target: self,
            action: #selector(closeTapped))
        navigationItem.leftBarButtonItem = quitButton
        navigationItem.leftBarButtonItem?.tintColor = DesignSystem.R.color.secRed()
    }
    
}

extension SportTypeSelectViewController: SportTypeSelectViewControllerLogic {}

@objc private extension SportTypeSelectViewController {
    func closeTapped() {
        router?.dismiss()
    }
}
