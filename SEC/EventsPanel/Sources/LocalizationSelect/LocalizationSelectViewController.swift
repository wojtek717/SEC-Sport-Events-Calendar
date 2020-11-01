import UIKit
import CommonUI
import DesignSystem

protocol LocalizationSelectViewControllerLogic: AnyObject {
    func presentUserPlace(with presentable: UserLocationViewPresentable)
}

final class LocalizationSelectViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var userLocationView: UserLocationView!
    @IBOutlet private var secTextField: SECTextFieldView!
    
    // MARK: - Public Properties

    var interactor: LocalizationSelectInteractorLogic?
    var router: LocalizationSelectRouterType?
    
    // MARK: - View Methods
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
        interactor?.getPlace()
    }
    
    override func viewDidLoad() {
        setup()
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        interactor?.getPlace()
        secTextField.setup(delegate: self,
                           icon: CommonUI.R.image.search())
    }
    
    private func setupNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Lokalizacja"
        
        let quitButton = UIBarButtonItem(
            image: CommonUI.R.image.close(),
            style: .plain,
            target: router,
            action: #selector(router?.dismiss))
        navigationItem.leftBarButtonItem = quitButton
        navigationItem.leftBarButtonItem?.tintColor = DesignSystem.R.color.secRed()
    }
}

extension LocalizationSelectViewController: LocalizationSelectViewControllerLogic {
    func presentUserPlace(with presentable: UserLocationViewPresentable) {
        userLocationView.setup(with: presentable)
    }
}

extension LocalizationSelectViewController: UITextFieldDelegate {
    
}
