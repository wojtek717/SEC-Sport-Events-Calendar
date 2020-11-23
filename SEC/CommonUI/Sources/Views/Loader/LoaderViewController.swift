import UIKit

final class LoaderViewController: UIViewController {
    
    @IBOutlet private var ballImageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 1.5,
                       delay: 0,
                       options: [.curveEaseInOut, .repeat]) {
            self.ballImageView.transform = CGAffineTransform(rotationAngle: .pi)
        }
    }
}
