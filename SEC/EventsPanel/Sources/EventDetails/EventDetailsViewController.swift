import UIKit
import Core
import DesignSystem
import CommonUI

protocol EventDetailsViewControllerLogic: AnyObject {
    func presentEventDetails(presentable: EventDetailsPresentable)
}

final class EventDetailsViewController: UIViewController {
    
    @IBOutlet private var locationView: UserLocationView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var beginDateLabel: UILabel!
    @IBOutlet var endDateLabel: UILabel!
    @IBOutlet var signedUpLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var signUpButton: SecButton!
    
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
        
        interactor?.fetchEventData()
    }

    // MARK: - Private Methods

    private func setupNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
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
    }
    
    @objc private func closeTapped() {
        router?.dismiss()
    }
}



extension EventDetailsViewController: EventDetailsViewControllerLogic {
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
    }
}
