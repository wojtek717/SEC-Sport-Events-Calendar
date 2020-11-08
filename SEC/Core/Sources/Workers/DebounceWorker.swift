import Foundation

public final class DebounceWorker {
    private var debounceTimer: Timer?

    private let interval: TimeInterval

    public init(interval: TimeInterval = 0.5) {
        self.interval = interval
    }

    /// Debounce the execution of the block that is passed as a parameter.
    /// Debounce time interval defaults to 0.5 seconds.
    /// - Parameter closure: instructions to be throttled
    public func debounce(_ block: @escaping () -> Void) {
        debounceTimer?.invalidate()
        debounceTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { _ in
            block()
        }

        guard let debounceTimer = debounceTimer else {
            return
        }

        RunLoop.current.add(debounceTimer, forMode: .common)
    }

    public func cancel() {
        debounceTimer?.invalidate()
        debounceTimer = nil
    }
}
