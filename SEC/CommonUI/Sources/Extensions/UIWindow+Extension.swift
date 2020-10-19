import Foundation

import UIKit

public extension UIWindow {
    func pushToViewController(newRootController: UIViewController,
                              transitionSubtype: CATransitionSubtype = .fromRight,
                              duration: TimeInterval = 0.33) {
        let transition = CATransition()
        transition.startProgress = 0.0
        transition.endProgress = 1.0
        transition.type = CATransitionType.push
        transition.subtype = transitionSubtype
        transition.duration = duration

        let transitionWindow: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
        transitionWindow?.backgroundColor = .white

        transitionWindow?.makeKeyAndVisible()

        layer.add(transition, forKey: kCATransition)
        rootViewController = newRootController
        makeKeyAndVisible()

        if let tranistionWindow = transitionWindow {
            DispatchQueue.main.asyncAfter(deadline: .now() + duration + 0.8) {
                tranistionWindow.removeFromSuperview()
            }
        }
    }
}
