import UIKit
import CommonUI

final class CreatorSportTypeDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Public Properties

    private var content = SportType.allCases
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = content[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CommonUI.R.reuseIdentifier.creatorSportTypeTableViewCell,
            for: indexPath)
        
        cell?.configure(with: item.title)
        
        return cell ?? UITableViewCell()
    }
}
