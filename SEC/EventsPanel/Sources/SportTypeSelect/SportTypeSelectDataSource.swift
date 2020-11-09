import UIKit

final class SportTypeSelectDataSource: NSObject, UITableViewDataSource {
    
    public var content = [SportTypeTableViewCellPresentable]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let presentableItem = content[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: R.reuseIdentifier.spotTypeTableViewCell,
            for: indexPath)
        cell?.configure(with: presentableItem)
        
        return cell ?? UITableViewCell()
    }
    
    
}
