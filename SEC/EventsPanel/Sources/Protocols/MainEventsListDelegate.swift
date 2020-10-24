public protocol MainEventsListDelegate: AnyObject {
    func didSelectItem(_ mainEventsListItem: MainEventsListRow,
                       atIndex index: Int)
}
