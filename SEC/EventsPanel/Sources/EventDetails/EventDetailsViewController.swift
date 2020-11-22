import UIKit
import Core
import CommonUI
import DesignSystem
import CommonUI

protocol EventDetailsViewControllerLogic: AnyObject {
    func presentEventDetails(presentable: EventDetailsPresentable)
    func presentButtons(isUserSignedUp: Bool)
}

final class EventDetailsViewController: UIViewController, LoaderPresenting {
    
    @IBOutlet private var locationView: UserLocationView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var beginDateLabel: UILabel!
    @IBOutlet private var endDateLabel: UILabel!
    @IBOutlet private var signedUpLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var signUpButton: SecButton!
    @IBOutlet private var signOutButton: SecButton!
    
    // MARK: - Public Properties
    
    var interactor: EventDetailsInteractorLogic?
    var router: EventDetailsRouterType?
    
    // MARK: - View Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar()

    }
    
    override func viewDidLoad() {
        setupButtons()
        
        presentLoader { [weak self] in
            self?.interactor?.viewDidLoad()
        }
    }

    // MARK: - Private Methods

    private func setupNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .white
        title = Core.R.string.localizable.eventDetails_title()
        
        let quitButton = UIBarButtonItem(
            image: CommonUI.R.image.close(),
            style: .plain,
            target: self,
            action: #selector(closeTapped))
        navigationItem.leftBarButtonItem = quitButton
        navigationItem.leftBarButtonItem?.tintColor = DesignSystem.R.color.secRed()
    }
    
    private func setupButtons() {
        signUpButton.setTitle(
            Core.R.string.localizable.eventDetails_sign_up_button(),
            for: [])
        
        signUpButton.addTarget(
            self,
            action: #selector(signUpButtonTapped),
            for: .touchUpInside)
        
        signOutButton.addTarget(
            self,
            action: #selector(signOutButtonTapped),
            for: .touchUpInside)
        
        signUpButton.isEnabled = interactor?.isUserLoggedIn() ?? false
    }
}

extension EventDetailsViewController: EventDetailsViewControllerLogic {
    func presentButtons(isUserSignedUp: Bool) {
        signUpButton.isHidden = !isUserSignedUp
        signOutButton.isHidden = isUserSignedUp
    }
    
    func presentEventDetails(presentable: EventDetailsPresentable) {
        locationView.setup(
            with: UserLocationViewPresentable(
                cityName: presentable.localizationName,
                postCode: presentable.postCode,
                country: presentable.city))
        
        titleLabel.text = presentable.title
        descriptionLabel.text = presentable.description
        beginDateLabel.text = presentable.startDate
        endDateLabel.text = presentable.endDate
        signedUpLabel.text = String(presentable.signedUp)
        
        hideLoader()
    }
}

@objc private extension EventDetailsViewController {
   func closeTapped() {
        router?.dismiss()
    }
    
    func signUpButtonTapped() {
        presentLoader { [weak self] in
            self?.interactor?.signUp()
        }
    }
    
    func signOutButtonTapped() {
        presentLoader { [weak self] in
            self?.interactor?.signOut()
        }
    }
}
