import UIKit

final class MainEventsListDataSource: NSObject, UITableViewDataSource {
    // MARK: - Private Properties
    
    private weak var delegate: MainEventsListDelegate?
    private var lastContentOffset: CGFloat = 0
    
    // MARK: - Public Properties

    public var content = [MainEventsListRow]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = content[indexPath.row]
        
        switch item {
        case let .event(presentable):
            let cell = tableView.dequeueReusableCell(
                withIdentifier: R.reuseIdentifier.eventTableViewCell,
                for: indexPath)
            cell?.configure(with: presentable)
            return cell ?? UITableViewCell()
        }
    }
    
    public func use(mainEventsListDelegate: MainEventsListDelegate?) {
        self.delegate = mainEventsListDelegate
    }
}

extension MainEventsListDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = content[indexPath.row]
        
        switch item {
        case .event(_):
            return 120.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = content[indexPath.row]
        
        delegate?.didSelectItem(item, atIndex: indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let delta = scrollView.contentOffset.y - lastContentOffset
        
        delegate?.scrollViewDidScroll(delta: delta)
        
        lastContentOffset = scrollView.contentOffset.y
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        lastContentOffset = scrollView.contentOffset.y
    }
}
