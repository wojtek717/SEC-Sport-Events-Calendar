import UIKit
import Core
import DesignSystem
import CommonUI

protocol CreatorThirdStepViewControllerLogic: AnyObject {}

final class CreatorThirdStepViewController: UIViewController {
    
    // MARK: - @IBOutlets

    @IBOutlet private var nextButton: SecButton!
    @IBOutlet private var beginDateLabel: UILabel!
    @IBOutlet private var endDateLabel: UILabel!
    @IBOutlet private var beginDatePicker: UIDatePicker!
    @IBOutlet private var endDatePicker: UIDatePicker!
    @IBOutlet private var cornerImageView: UIImageView!
    
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
        
        setup()
    }
    
    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "When?"
    }
    
    private func setup() {
        cornerImageView.image = CommonUI.R.image.tenisBall()
        
        nextButton.addTarget(
            self,
            action: #selector(nextButtonTapped),
            for: .touchUpInside)
    }
    
    @objc private func nextButtonTapped() {
        interactor?.setDate(beginDate: beginDatePicker.date,
                            endDate: endDatePicker.date)
        router?.navigateToFourthStep()
    }
}

extension CreatorThirdStepViewController: CreatorThirdStepViewControllerLogic {}
