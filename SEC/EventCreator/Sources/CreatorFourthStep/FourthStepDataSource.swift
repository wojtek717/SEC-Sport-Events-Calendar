import UIKit
import CommonUI

final class FourthStepDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Public Properties

    public var content = [LocalizationTableViewCellPresentable]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let presentableItem = content[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CommonUI.R.reuseIdentifier.localizationTableViewCell,
            for: indexPath)
        cell?.configure(with: presentableItem)
        
        return cell ?? UITableViewCell()
    }
}
