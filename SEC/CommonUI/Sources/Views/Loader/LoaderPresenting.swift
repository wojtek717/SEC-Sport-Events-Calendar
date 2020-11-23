import UIKit

public protocol LoaderPresenting: AnyObject {
    func presentLoader()
    func presentLoader(_ completion: @escaping (() -> Void))
    func hideLoader(_ completion: @escaping (() -> Void))
    func hideLoader()
}

public extension LoaderPresenting where Self: UIViewController {
    func presentLoader() {
        presentLoader {}
    }
    
    func presentLoader(_ completion: @escaping (() -> Void)) {
        DispatchQueue.main.async {
            let loaderViewController = LoaderViewController(nib: R.nib.loaderViewController)
            loaderViewController.modalPresentationStyle = .overFullScreen
            loaderViewController.modalTransitionStyle = .crossDissolve
            self.present(
                loaderViewController,
                animated: true,
                completion: completion)
        }
    }

    func hideLoader(_ completion: @escaping (() -> Void)) {
        DispatchQueue.main.async {
            if let loader = self.presentedViewController as? LoaderViewController {
                loader.dismiss(
                    animated: true,
                    completion: completion)
            } else {
                completion()
            }
        }
    }

    func hideLoader() {
        hideLoader {}
    }
}
